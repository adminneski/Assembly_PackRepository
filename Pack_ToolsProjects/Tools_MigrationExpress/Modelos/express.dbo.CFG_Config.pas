unit express.dbo.CFG_CONFIG;

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
  [Table('CFG_Config', '')]
  TDtoCFG_Config = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FCFG_DESCRICAO: String;
    FCOM_CODIGOPAIS: String;
    FCFG_PAIS: String;
    FCFG_LICENSEKEY: TBlob;
    FCFG_LICENSEKEYACTIVATION: TBlob;
    FFPG_TIPOPAGAMENTO: Integer;
    FCFG_TIPOEMPRESA: String;
    FCFG_PORTEFEDERAL: String;
    FCFG_PORTEESTADUAL: String;
    FCFG_PATHEXPORTACAOXML: String;
    FCFG_PATHEXPORTACAOCONTABIL: String;
    FCFG_TOTALGGFDIARIOPRODUCAO: Double;
    FCFG_RATEIOPRODUCAO: String;
    FCFG_CHEQUECLIENTEMAXPRORROGAR: Integer;
    FCFG_CODIGOLOJAMATRIZ: String;
    FCFG_CONFIGURACOES: String;
    FCFG_DATAALTERACAO: TDateTime;
    FCFG_DIASATRASOPERMITIDO: Integer;
    FCFG_DIASBLOQUEARCLIENTE: Integer;
    FCFG_DIASVALIDADEORCAMENTO: Integer;
    FCFG_DIASMAXDEVOLUCAO: Integer;
    FCFG_DIASPARAPROTESTAR: Integer;
    FCFG_DIASTRAVARCLIENTEINATIVO: Integer;
    FCFG_LIMITEDIFERENCANFE: Double;
    FCFG_TITULORELATORIO: String;
    FCFG_PERCENTUALMAXDESCTO: Double;
    FCFG_TAXADEJUROSAOMES: Double;
    FCFG_VALORMAXPESSOAFISICA: Double;
    FCFG_VALORMINFATURAMENTO: Double;
    FBCO_CODIGOPADRAO: Integer;
    FCTA_CODIGOPADRAO: Integer;
    FFPG_CODIGOPADRAO: Integer;
    FPRZ_CODIGOPADRAO: Integer;
    FTAB_CODIGOPADRAO: Integer;
    FCST_CODIGOPADRAO: String;
    FCLI_CODIGOPADRAO: Integer;
    FVND_CODIGOPADRAO: Integer;
    FFOR_INTEGRACAOCONTABIL: String;
    FCLI_INTEGRACAOCONTABIL: String;
    FCTA_CODIGOPADRAOCHEQUEPENDENTE: Integer;
    FNTO_CODIGOPADRAOCOMPRA: Integer;
    FNTO_CODIGOPADRAOVENDA: Integer;
    FNTO_CODIGOPADRAODEVOLUCAO: Integer;
    FNTO_CODIGOPADRAOVENDACPF: Integer;
    FNTO_CODIGOPADRAOSERVICO: Integer;
    FCFG_REGISTROSINTEGRA: String;
    FCFG_PERCENTUALCONTSOCIALMKP: Double;
    FCFG_PERCENTUALCOMISSAOVNDMKP: Double;
    FCFG_PERCENTUALIMPOSTORENDAMKP: Double;
    FCFG_PERCENTUALADMINISTRATIVOMKP: Double;
    FCFG_PERCENTUALSIMPLESMKP_1: Double;
    FCFG_PERCENTUALSIMPLESMKP_2: Double;
    FTDC_CODIGOPADRAO: String;
    FCFG_PATHEXPORTACAOCOLETOR: String;
    FCFG_PATHEXPORTACAOBALANCA: String;
    FCFG_VRDESCTOARREDONDAMENTOPDV: Double;
    FCFG_OBSERVACAOEXPORTACAOCNAB_1: String;
    FCFG_OBSERVACAOEXPORTACAOCNAB_2: String;
    FCFG_OBSERVACAOEXPORTACAOCNAB_3: String;
    FCFG_OBSERVACAOEXPORTACAOCNAB_4: String;
    FCFG_OBSERVACAOEXPORTACAOCNAB_5: String;
    FCFG_ORDEMFILTRAPRODUTOS: String;
    FCFG_TIPOENVIOREGISTROSINTEGRA74: String;
    FTAB_CODIGOATACADO: Integer;
    FCFG_PATHSETTING: String;
    FCFG_PATHLOGORELATORIO: String;
    FCFG_MODOFUNCIONAMENTO: Integer;
    FTRP_CODIGOPADRAO: Integer;
    FCFG_EMAILENVIO: String;
    FCFG_EMAILUSUARIOENVIO: String;
    FCFG_EMAILSENHAENVIO: String;
    FCFG_EMAILPORTAENVIO: Integer;
    FCFG_EMAILSSL: String;
    FCFG_EMAILTLS: String;
    FCFG_MENSAGEMCARTACOBRANCA1: String;
    FCFG_MENSAGEMCARTACOBRANCA2: String;
    FPOR_CODIGOPADRAO: Integer;
    FCFG_EMAILSERVIDORENVIO: String;
    FCFG_VALORTOLERANCIADESCTO: Double;
    FCFG_VALORMINIMOPARCELAMENTO: Double;
    FCFG_MARKUPMINVENDA: Double;
    FGRP_CODIGOPADRAO: Integer;
    FSGP_CODIGOPADRAO: Integer;
    FCFG_TIPOIMPRESSAODOCTOBOLETO: String;
    FCFG_IBPTCHAVE: String;
    FCFG_IBPTVERSAO: String;
    FCFG_QTDCASADECIMALVALORUNITARIO: Integer;
    FCFG_QTDCASADECIMALQUANTIDADE: Integer;
    FCFG_CONFIGURACAOIMPRESSAOVENDA: String;
    FCFG_SENHALIBERACAOVENDA: String;
    FCFG_ESTOQUERESERVASAIDA: String;
    FCTA_CODIGOPADRAOANTECIPACAOFOR: Integer;
    FCTA_CODIGOPADRAOANTECIPACAOCLI: Integer;
    FCFG_TIPOFRETE: String;
    FCFOP_CODIGO_CTR: String;
    FMNF_CODIGO_CTR: String;
    FPES_CODIGO_CTR: Integer;
    FPLC_CODIGO_CTR: Integer;
    FCCU_CODIGO_CTR: Integer;
    FTDC_CODIGO_CTR: String;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FCTR_NATUREZA: String;
    FCTR_ESPECIE: String;
    FCTR_OBSERVACAO: String;
    FCTR_NATUREZACARGA: String;
    FCTR_PERCENTUALICMS: Double;
    FCTR_CONFIGURACOES: String;
    FCTR_APOLICE: String;
    FCTR_COBRADORA: String;
    FCTR_FINALIDADE: String;
    FCTR_TIPOEMISSAO: String;
    FCTR_AMBIENTEENVIO: String;
    FCTR_TIPODACTE: String;
    FCTR_CERTIFICADONUMEROSERIE: String;
    FCTR_CERTIFICADOSENHA: String;
    FCTR_SSLLIB: String;
    FCTR_UFDESTINO: String;
    FCTR_PROXYHOST: String;
    FCTR_PROXYPORTA: Integer;
    FCTR_PROXYUSUARIO: String;
    FCTR_PROXYSENHA: String;
    FCTR_PATHLOGOMARCA: String;
    FCTR_PATHSCHEMA: String;
    FCTR_PATHREPOSITORIO: String;
    FCTR_PATHARQENVIORESPOSTA: String;
    FCTR_ATUALIZARCTEINICIAR: String;
    FCTR_ENVIAREMAILAPOSAUTORIZACAO: String;
    FCTR_TIPOMEIOTRANSPORTE: String;
    FCTR_SERIECONTIGENCIA: String;
    FCTR_CONTRATORODOVIARIOCPA: String;
    FCTR_MANIFESTOCARGACPA: String;
    FPRO_CODIGO_CTR: Integer;
    FFOR_CODIGO_CTR: Integer;
    FCTR_RNTRC: String;
    FNTO_CODIGO_CTR: Integer;
    FPRZ_CODIGO_CTR: Integer;
    FFPG_CODIGO_CTR: Integer;
    FLEF_CODIGO_CTR: Integer;
    FCTR_EMAILSERVIDORENVIO: String;
    FCTR_EMAILENVIO: String;
    FCTR_EMAILUSUARIOENVIO: String;
    FCTR_EMAILSENHAENVIO: String;
    FCTR_EMAILPORTAENVIO: Integer;
    FCTR_EMAILSSL: String;
    FCTR_EMAILTLS: String;
    FMFC_TIPOEMISSAO: String;
    FMFC_AMBIENTEENVIO: String;
    FMFC_TIPODACTE: String;
    FMFC_CERTIFICADONUMEROSERIE: String;
    FMFC_CERTIFICADOSENHA: String;
    FMFC_SSLLIB: String;
    FMFC_UFDESTINO: String;
    FMFC_PROXYHOST: String;
    FMFC_PROXYPORTA: Integer;
    FMFC_PROXYUSUARIO: String;
    FMFC_PROXYSENHA: String;
    FMFC_PATHLOGOMARCA: String;
    FMFC_PATHSCHEMA: String;
    FMFC_PATHREPOSITORIO: String;
    FMFC_PATHARQENVIORESPOSTA: String;
    FMFC_ATUALIZARCTEINICIAR: String;
    FMFC_ENVIAREMAILAPOSAUTORIZACAO: String;
    FMFC_EMAILSERVIDORENVIO: String;
    FMFC_EMAILENVIO: String;
    FMFC_EMAILUSUARIOENVIO: String;
    FMFC_EMAILSENHAENVIO: String;
    FMFC_EMAILPORTAENVIO: Integer;
    FMFC_EMAILSSL: String;
    FMFC_EMAILTLS: String;
    FMNF_CODIGO_MFC: String;
    FMFC_SERIE: String;
    FMFC_SUBSERIE: String;
    FMFC_SERIECONTIGENCIA: String;
    FCTR_PERCENTUALIBPT: Double;
    FCTR_TIPOFRETE: String;
    FCTR_PERCENTUALIBPTESTADUAL: Double;
    FCTR_PERCENTUALIBPTNACIONAL: Double;
    FMFC_TIPOEMITENTE: String;
    FCTR_GLOBALIZADO: String;
    FCTR_USUARIOAPISEGURADORA: String;
    FCTR_SENHAAPISEGURADORA: String;
    FCTR_CODIGOAPISEGURADORA: String;
    FCTR_AVERBARAUTOMATICAMENTE: String;
    FMFC_DECLARARAUTOMATICAMENTE: String;
    FNFE_FINALIDADE: String;
    FNFE_TIPOEMISSAO: String;
    FNFE_AMBIENTEENVIO: String;
    FNFE_PATHEXPORTACAO: String;
    FNFE_PATHIMPORTACAO: String;
    FCFG_PERCENTUALCDICMSSIMPLES: Double;
    FNFE_TIPODANFE: String;
    FNFE_CERTIFICADONUMEROSERIE: String;
    FNFE_CERTIFICADOSENHA: String;
    FNFE_SSLLIB: String;
    FNFE_UFDESTINO: String;
    FNFE_PROXYHOST: String;
    FNFE_PROXYPORTA: Integer;
    FNFE_PROXYUSUARIO: String;
    FNFE_PROXYSENHA: String;
    FNFE_PATHLOGOMARCA: String;
    FNFE_PATHSCHEMA: String;
    FNFE_PATHREPOSITORIO: String;
    FNFE_PATHARQENVIORESPOSTA: String;
    FNFE_ATUALIZARNOTASINICIAR: String;
    FNFE_ENVIAREMAILAPOSAUTORIZACAO: String;
    FMNF_CODIGOPADRAOSAIDA: String;
    FMNF_CODIGOPADRAOENTRADA: String;
    FMNF_CODIGOPADRAONFC: String;
    FNFE_SERIENFE: String;
    FNFE_SERIENFC: String;
    FNFE_SERIENFECONTIGENCIA: String;
    FNFE_ESPECIE: String;
    FNFE_MARCA: String;
    FNFSE_SERIESERVICO: String;
    FMNF_CODIGOPADRAOSERVICO: String;
    FNFE_TIPODESCRICAOPRODUTO: String;
    FNFE_MENSAGEMRODAPENOTASAIDA: String;
    FNFE_MENSAGEMRODAPENOTAENTRADA: String;
    FNFE_EMAILSERVIDORENVIO: String;
    FNFE_EMAILENVIO: String;
    FNFE_EMAILUSUARIOENVIO: String;
    FNFE_EMAILSENHAENVIO: String;
    FNFE_EMAILPORTAENVIO: Integer;
    FNFE_EMAILSSL: String;
    FNFE_EMAILTLS: String;
    FNFE_ORDEMIMPRESSAOITENS: String;
    FNFE_CODIGOIDCSC: Integer;
    FNFE_CODIGOCSC: String;
    FNFE_MOTIVOCONTIGENCIA: String;
    FNFE_IMPRIMENOTAPROMISSORIANFCE: String;
    FNFSE_AMBIENTEENVIO: String;
    FNFSE_CERTIFICADONUMEROSERIE: String;
    FNFSE_CERTIFICADOSENHA: String;
    FNFSE_SSLLIB: String;
    FNFSE_IBGECIDADE: String;
    FNFSE_NOMECIDADE: String;
    FNFSE_PROXYHOST: String;
    FNFSE_PROXYPORTA: Integer;
    FNFSE_PROXYUSUARIO: String;
    FNFSE_PROXYSENHA: String;
    FNFSE_PATHLOGOMARCA: String;
    FNFSE_PATHLOGOMARCAPREFEITURA: String;
    FNFSE_PATHSCHEMAPROVEDOR: String;
    FNFSE_PATHREPOSITORIO: String;
    FNFSE_PATHARQUIVOINI: String;
    FNFSE_ATUALIZARNOTASINICIAR: String;
    FNFSE_ENVIAREMAILAPOSAUTORIZACAO: String;
    FNFSE_WEBUSUARIO: String;
    FNFSE_WEBSENHA: String;
    FNFSE_WEBFRASESECRETA: String;
    FNFSE_REGIMETRIBUTACAO: Integer;
    FNFSE_INCENTIVADORCULTURAL: String;
    FNFSE_PATHARQENVIORESPOSTA: String;
    FNFSE_VALORMINRETENCAOFEDERAL: Double;
    FNFSE_VALORMINRETENCAOIR: Double;
    FNFE_CNPJSEFAZUFEMITENTE: String;
    FNFE_DADOSCERTIFICADO_A1PFX: TBlob;
    FCFG_IND_ATIV: String;
    FCFG_TIPO_ESCRIT: String;
    FCFG_IND_NAT_PJ: String;
    FCFG_COD_INC_TRIB: String;
    FCFG_IND_APRO_CRED: String;
    FCFG_IND_REG_CUM: String;
    FCFG_IND_ESCRI: String;
    FCFG_IND_SIT_ESP: String;
    FCFG_COD_TIPO_CONT: String;
    FCFG_GERASPED: String;
    FCFG_ACPREVIDENCIARIARECEITAB: String;
    FCFG_COD_VER_FISCAL: String;
    FCFG_COD_REC_FISCAL: String;
    FCFG_COD_VER_SPEDPC: String;
    FCFG_COD_REC_SPEDPC: String;
    FCFG_NUM_CAMPO: String;
    FCFG_COD_REC_M205: String;
    FCFG_COD_REC_M605: String;
    FCFG_COD_1400_PRODUTOR: String;
    FCFG_COD_1400_VEICULO: String;
    FCFG_COD_1400_TRANSPORTE: String;
    FCFG_CONFIGURACOES_SPED: String;
    FPLC_CODIGOPADRAOJUROSCRE: Integer;
    FPLC_CODIGOPADRAOMULTACRE: Integer;
    FPLC_CODIGOPADRAODESPESASCRE: Integer;
    FPLC_CODIGOPADRAOCARTORIOCRE: Integer;
    FPLC_CODIGOPADRAODESCONTOCRE: Integer;
    FPLC_CODIGOPADRAODESPCARTAOCRE: Integer;
    FCCU_CODIGOPADRAOFINANCEIROCRE: Integer;
    FPLC_CODIGOPADRAOJUROSCPA: Integer;
    FPLC_CODIGOPADRAOMULTACPA: Integer;
    FPLC_CODIGOPADRAODESCONTOCPA: Integer;
    FPLC_CODIGOPADRAODESPESASCPA: Integer;
    FCCU_CODIGOPADRAOFINANCEIROCPA: Integer;
    FCCU_CODIGOPADRAOPRODUCAO: Integer;
    FPLC_CODIGOPADRAOPRODUCAO: Integer;
    FPLC_CODIGOPADRAOTRANSFERENCIA: Integer;
    FCCU_CODIGOPADRAOTRANSFERENCIA: Integer;
    FPLC_CODIGOPADRAOTARIFABOLETOCRE: Integer;
    FPLC_CODIGOPADRAOBCX: Integer;
    FCCU_CODIGOPADRAOBCX: Integer;
    FPLC_CODIGOPADRAONFE: Integer;
    FCCU_CODIGOPADRAONFE: Integer;
    FPLC_CODIGOPADRAOSEE: Integer;
    FCCU_CODIGOPADRAOSEE: Integer;
    FCCU_CODIGOPADRAOUNICO: Integer;
    FPLC_CODIGOPADRAOANTECIPACAOFOR: Integer;
    FCCU_CODIGOPADRAOANTECIPACAOFOR: Integer;
    FPLC_CODIGOPADRAOANTECIPACAOCLI: Integer;
    FCCU_CODIGOPADRAOANTECIPACAOCLI: Integer;
    FCFG_TRIBUTACAOENTRADACST_00: String;
    FCFG_TRIBUTACAOENTRADACST_10: String;
    FCFG_TRIBUTACAOENTRADACST_20: String;
    FCFG_TRIBUTACAOENTRADACST_30: String;
    FCFG_TRIBUTACAOENTRADACST_40: String;
    FCFG_TRIBUTACAOENTRADACST_41: String;
    FCFG_TRIBUTACAOENTRADACST_50: String;
    FCFG_TRIBUTACAOENTRADACST_51: String;
    FCFG_TRIBUTACAOENTRADACST_60: String;
    FCFG_TRIBUTACAOENTRADACST_70: String;
    FCFG_TRIBUTACAOENTRADACST_90: String;
    FCFG_TRIBUTACAOSAIDACST_00: String;
    FCFG_TRIBUTACAOSAIDACST_10: String;
    FCFG_TRIBUTACAOSAIDACST_20: String;
    FCFG_TRIBUTACAOSAIDACST_30: String;
    FCFG_TRIBUTACAOSAIDACST_40: String;
    FCFG_TRIBUTACAOSAIDACST_41: String;
    FCFG_TRIBUTACAOSAIDACST_50: String;
    FCFG_TRIBUTACAOSAIDACST_51: String;
    FCFG_TRIBUTACAOSAIDACST_60: String;
    FCFG_TRIBUTACAOSAIDACST_70: String;
    FCFG_TRIBUTACAOSAIDACST_90: String;
    FCST_CODIGOPADRAOENTRADACST_00: String;
    FCST_CODIGOPADRAOENTRADACST_10: String;
    FCST_CODIGOPADRAOENTRADACST_20: String;
    FCST_CODIGOPADRAOENTRADACST_30: String;
    FCST_CODIGOPADRAOENTRADACST_40: String;
    FCST_CODIGOPADRAOENTRADACST_41: String;
    FCST_CODIGOPADRAOENTRADACST_50: String;
    FCST_CODIGOPADRAOENTRADACST_51: String;
    FCST_CODIGOPADRAOENTRADACST_60: String;
    FCST_CODIGOPADRAOENTRADACST_70: String;
    FCST_CODIGOPADRAOENTRADACST_90: String;
    FCFOP_CODIGOPADRAOENTRADACST_00: String;
    FCFOP_CODIGOPADRAOENTRADACST_10: String;
    FCFOP_CODIGOPADRAOENTRADACST_20: String;
    FCFOP_CODIGOPADRAOENTRADACST_30: String;
    FCFOP_CODIGOPADRAOENTRADACST_40: String;
    FCFOP_CODIGOPADRAOENTRADACST_41: String;
    FCFOP_CODIGOPADRAOENTRADACST_50: String;
    FCFOP_CODIGOPADRAOENTRADACST_51: String;
    FCFOP_CODIGOPADRAOENTRADACST_60: String;
    FCFOP_CODIGOPADRAOENTRADACST_70: String;
    FCFOP_CODIGOPADRAOENTRADACST_90: String;
    FNCM_CODIGOPADRAOENTRADACST_00: Integer;
    FNCM_CODIGOPADRAOENTRADACST_10: Integer;
    FNCM_CODIGOPADRAOENTRADACST_20: Integer;
    FNCM_CODIGOPADRAOENTRADACST_30: Integer;
    FNCM_CODIGOPADRAOENTRADACST_40: Integer;
    FNCM_CODIGOPADRAOENTRADACST_41: Integer;
    FNCM_CODIGOPADRAOENTRADACST_50: Integer;
    FNCM_CODIGOPADRAOENTRADACST_51: Integer;
    FNCM_CODIGOPADRAOENTRADACST_60: Integer;
    FNCM_CODIGOPADRAOENTRADACST_70: Integer;
    FNCM_CODIGOPADRAOENTRADACST_90: Integer;
  public 
    { Public declarations } 
     const Table      = 'CFG_Config';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFG_DESCRICAO', ftString, 50)]
    [Dictionary('CFG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_DESCRICAO: String read FCFG_DESCRICAO write FCFG_DESCRICAO;
    const CFG_DESCRICAO_Name = 'CFG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGOPAIS', ftString, 4)]
    [Dictionary('COM_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGOPAIS: String read FCOM_CODIGOPAIS write FCOM_CODIGOPAIS;
    const COM_CODIGOPAIS_Name = 'COM_CODIGOPAIS';

    [Restrictions([NoValidate])]
    [Column('CFG_PAIS', ftString, 100)]
    [Dictionary('CFG_PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PAIS: String read FCFG_PAIS write FCFG_PAIS;
    const CFG_PAIS_Name = 'CFG_PAIS';

    [Restrictions([NoValidate])]
    [Column('CFG_LICENSEKEY', ftBlob)]
    [Dictionary('CFG_LICENSEKEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_LICENSEKEY: TBlob read FCFG_LICENSEKEY write FCFG_LICENSEKEY;
    const CFG_LICENSEKEY_Name = 'CFG_LICENSEKEY';

    [Restrictions([NoValidate])]
    [Column('CFG_LICENSEKEYACTIVATION', ftBlob)]
    [Dictionary('CFG_LICENSEKEYACTIVATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_LICENSEKEYACTIVATION: TBlob read FCFG_LICENSEKEYACTIVATION write FCFG_LICENSEKEYACTIVATION;
    const CFG_LICENSEKEYACTIVATION_Name = 'CFG_LICENSEKEYACTIVATION';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOEMPRESA', ftString, 1)]
    [Dictionary('CFG_TIPOEMPRESA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOEMPRESA: String read FCFG_TIPOEMPRESA write FCFG_TIPOEMPRESA;
    const CFG_TIPOEMPRESA_Name = 'CFG_TIPOEMPRESA';

    [Restrictions([NoValidate])]
    [Column('CFG_PORTEFEDERAL', ftString, 1)]
    [Dictionary('CFG_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PORTEFEDERAL: String read FCFG_PORTEFEDERAL write FCFG_PORTEFEDERAL;
    const CFG_PORTEFEDERAL_Name = 'CFG_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('CFG_PORTEESTADUAL', ftString, 1)]
    [Dictionary('CFG_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PORTEESTADUAL: String read FCFG_PORTEESTADUAL write FCFG_PORTEESTADUAL;
    const CFG_PORTEESTADUAL_Name = 'CFG_PORTEESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHEXPORTACAOXML', ftString, 300)]
    [Dictionary('CFG_PATHEXPORTACAOXML', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHEXPORTACAOXML: String read FCFG_PATHEXPORTACAOXML write FCFG_PATHEXPORTACAOXML;
    const CFG_PATHEXPORTACAOXML_Name = 'CFG_PATHEXPORTACAOXML';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHEXPORTACAOCONTABIL', ftString, 300)]
    [Dictionary('CFG_PATHEXPORTACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHEXPORTACAOCONTABIL: String read FCFG_PATHEXPORTACAOCONTABIL write FCFG_PATHEXPORTACAOCONTABIL;
    const CFG_PATHEXPORTACAOCONTABIL_Name = 'CFG_PATHEXPORTACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('CFG_TOTALGGFDIARIOPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('CFG_TOTALGGFDIARIOPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_TOTALGGFDIARIOPRODUCAO: Double read FCFG_TOTALGGFDIARIOPRODUCAO write FCFG_TOTALGGFDIARIOPRODUCAO;
    const CFG_TOTALGGFDIARIOPRODUCAO_Name = 'CFG_TOTALGGFDIARIOPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('CFG_RATEIOPRODUCAO', ftString, 1)]
    [Dictionary('CFG_RATEIOPRODUCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_RATEIOPRODUCAO: String read FCFG_RATEIOPRODUCAO write FCFG_RATEIOPRODUCAO;
    const CFG_RATEIOPRODUCAO_Name = 'CFG_RATEIOPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('CFG_CHEQUECLIENTEMAXPRORROGAR', ftInteger)]
    [Dictionary('CFG_CHEQUECLIENTEMAXPRORROGAR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CHEQUECLIENTEMAXPRORROGAR: Integer read FCFG_CHEQUECLIENTEMAXPRORROGAR write FCFG_CHEQUECLIENTEMAXPRORROGAR;
    const CFG_CHEQUECLIENTEMAXPRORROGAR_Name = 'CFG_CHEQUECLIENTEMAXPRORROGAR';

    [Restrictions([NoValidate])]
    [Column('CFG_CODIGOLOJAMATRIZ', ftString, 3)]
    [Dictionary('CFG_CODIGOLOJAMATRIZ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CODIGOLOJAMATRIZ: String read FCFG_CODIGOLOJAMATRIZ write FCFG_CODIGOLOJAMATRIZ;
    const CFG_CODIGOLOJAMATRIZ_Name = 'CFG_CODIGOLOJAMATRIZ';

    [Restrictions([NoValidate])]
    [Column('CFG_CONFIGURACOES', ftString, 100)]
    [Dictionary('CFG_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CONFIGURACOES: String read FCFG_CONFIGURACOES write FCFG_CONFIGURACOES;
    const CFG_CONFIGURACOES_Name = 'CFG_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASATRASOPERMITIDO', ftInteger)]
    [Dictionary('CFG_DIASATRASOPERMITIDO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASATRASOPERMITIDO: Integer read FCFG_DIASATRASOPERMITIDO write FCFG_DIASATRASOPERMITIDO;
    const CFG_DIASATRASOPERMITIDO_Name = 'CFG_DIASATRASOPERMITIDO';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASBLOQUEARCLIENTE', ftInteger)]
    [Dictionary('CFG_DIASBLOQUEARCLIENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASBLOQUEARCLIENTE: Integer read FCFG_DIASBLOQUEARCLIENTE write FCFG_DIASBLOQUEARCLIENTE;
    const CFG_DIASBLOQUEARCLIENTE_Name = 'CFG_DIASBLOQUEARCLIENTE';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASVALIDADEORCAMENTO', ftInteger)]
    [Dictionary('CFG_DIASVALIDADEORCAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASVALIDADEORCAMENTO: Integer read FCFG_DIASVALIDADEORCAMENTO write FCFG_DIASVALIDADEORCAMENTO;
    const CFG_DIASVALIDADEORCAMENTO_Name = 'CFG_DIASVALIDADEORCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASMAXDEVOLUCAO', ftInteger)]
    [Dictionary('CFG_DIASMAXDEVOLUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASMAXDEVOLUCAO: Integer read FCFG_DIASMAXDEVOLUCAO write FCFG_DIASMAXDEVOLUCAO;
    const CFG_DIASMAXDEVOLUCAO_Name = 'CFG_DIASMAXDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASPARAPROTESTAR', ftInteger)]
    [Dictionary('CFG_DIASPARAPROTESTAR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASPARAPROTESTAR: Integer read FCFG_DIASPARAPROTESTAR write FCFG_DIASPARAPROTESTAR;
    const CFG_DIASPARAPROTESTAR_Name = 'CFG_DIASPARAPROTESTAR';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASTRAVARCLIENTEINATIVO', ftInteger)]
    [Dictionary('CFG_DIASTRAVARCLIENTEINATIVO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASTRAVARCLIENTEINATIVO: Integer read FCFG_DIASTRAVARCLIENTEINATIVO write FCFG_DIASTRAVARCLIENTEINATIVO;
    const CFG_DIASTRAVARCLIENTEINATIVO_Name = 'CFG_DIASTRAVARCLIENTEINATIVO';

    [Restrictions([NoValidate])]
    [Column('CFG_LIMITEDIFERENCANFE', ftBCD, 3604548, 2)]
    [Dictionary('CFG_LIMITEDIFERENCANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_LIMITEDIFERENCANFE: Double read FCFG_LIMITEDIFERENCANFE write FCFG_LIMITEDIFERENCANFE;
    const CFG_LIMITEDIFERENCANFE_Name = 'CFG_LIMITEDIFERENCANFE';

    [Restrictions([NoValidate])]
    [Column('CFG_TITULORELATORIO', ftString, 50)]
    [Dictionary('CFG_TITULORELATORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TITULORELATORIO: String read FCFG_TITULORELATORIO write FCFG_TITULORELATORIO;
    const CFG_TITULORELATORIO_Name = 'CFG_TITULORELATORIO';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALMAXDESCTO', ftBCD, 3342425, 2)]
    [Dictionary('CFG_PERCENTUALMAXDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALMAXDESCTO: Double read FCFG_PERCENTUALMAXDESCTO write FCFG_PERCENTUALMAXDESCTO;
    const CFG_PERCENTUALMAXDESCTO_Name = 'CFG_PERCENTUALMAXDESCTO';

    [Restrictions([NoValidate])]
    [Column('CFG_TAXADEJUROSAOMES', ftBCD, 6357075, 2)]
    [Dictionary('CFG_TAXADEJUROSAOMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_TAXADEJUROSAOMES: Double read FCFG_TAXADEJUROSAOMES write FCFG_TAXADEJUROSAOMES;
    const CFG_TAXADEJUROSAOMES_Name = 'CFG_TAXADEJUROSAOMES';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORMAXPESSOAFISICA', ftBCD, 4456525, 2)]
    [Dictionary('CFG_VALORMAXPESSOAFISICA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORMAXPESSOAFISICA: Double read FCFG_VALORMAXPESSOAFISICA write FCFG_VALORMAXPESSOAFISICA;
    const CFG_VALORMAXPESSOAFISICA_Name = 'CFG_VALORMAXPESSOAFISICA';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORMINFATURAMENTO', ftBCD, 5439560, 2)]
    [Dictionary('CFG_VALORMINFATURAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORMINFATURAMENTO: Double read FCFG_VALORMINFATURAMENTO write FCFG_VALORMINFATURAMENTO;
    const CFG_VALORMINFATURAMENTO_Name = 'CFG_VALORMINFATURAMENTO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGOPADRAO', ftInteger)]
    [Dictionary('BCO_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGOPADRAO: Integer read FBCO_CODIGOPADRAO write FBCO_CODIGOPADRAO;
    const BCO_CODIGOPADRAO_Name = 'BCO_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOPADRAO', ftInteger)]
    [Dictionary('CTA_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOPADRAO: Integer read FCTA_CODIGOPADRAO write FCTA_CODIGOPADRAO;
    const CTA_CODIGOPADRAO_Name = 'CTA_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGOPADRAO', ftInteger)]
    [Dictionary('FPG_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGOPADRAO: Integer read FFPG_CODIGOPADRAO write FFPG_CODIGOPADRAO;
    const FPG_CODIGOPADRAO_Name = 'FPG_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGOPADRAO', ftInteger)]
    [Dictionary('PRZ_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGOPADRAO: Integer read FPRZ_CODIGOPADRAO write FPRZ_CODIGOPADRAO;
    const PRZ_CODIGOPADRAO_Name = 'PRZ_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGOPADRAO', ftInteger)]
    [Dictionary('TAB_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGOPADRAO: Integer read FTAB_CODIGOPADRAO write FTAB_CODIGOPADRAO;
    const TAB_CODIGOPADRAO_Name = 'TAB_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAO', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAO: String read FCST_CODIGOPADRAO write FCST_CODIGOPADRAO;
    const CST_CODIGOPADRAO_Name = 'CST_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CLI_CODIGOPADRAO', ftInteger)]
    [Dictionary('CLI_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLI_CODIGOPADRAO: Integer read FCLI_CODIGOPADRAO write FCLI_CODIGOPADRAO;
    const CLI_CODIGOPADRAO_Name = 'CLI_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGOPADRAO', ftInteger)]
    [Dictionary('VND_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGOPADRAO: Integer read FVND_CODIGOPADRAO write FVND_CODIGOPADRAO;
    const VND_CODIGOPADRAO_Name = 'VND_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('FOR_INTEGRACAOCONTABIL', ftString, 18)]
    [Dictionary('FOR_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_INTEGRACAOCONTABIL: String read FFOR_INTEGRACAOCONTABIL write FFOR_INTEGRACAOCONTABIL;
    const FOR_INTEGRACAOCONTABIL_Name = 'FOR_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('CLI_INTEGRACAOCONTABIL', ftString, 18)]
    [Dictionary('CLI_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_INTEGRACAOCONTABIL: String read FCLI_INTEGRACAOCONTABIL write FCLI_INTEGRACAOCONTABIL;
    const CLI_INTEGRACAOCONTABIL_Name = 'CLI_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOPADRAOCHEQUEPENDENTE', ftInteger)]
    [Dictionary('CTA_CODIGOPADRAOCHEQUEPENDENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOPADRAOCHEQUEPENDENTE: Integer read FCTA_CODIGOPADRAOCHEQUEPENDENTE write FCTA_CODIGOPADRAOCHEQUEPENDENTE;
    const CTA_CODIGOPADRAOCHEQUEPENDENTE_Name = 'CTA_CODIGOPADRAOCHEQUEPENDENTE';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOPADRAOCOMPRA', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAOCOMPRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAOCOMPRA: Integer read FNTO_CODIGOPADRAOCOMPRA write FNTO_CODIGOPADRAOCOMPRA;
    const NTO_CODIGOPADRAOCOMPRA_Name = 'NTO_CODIGOPADRAOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOPADRAOVENDA', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAOVENDA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAOVENDA: Integer read FNTO_CODIGOPADRAOVENDA write FNTO_CODIGOPADRAOVENDA;
    const NTO_CODIGOPADRAOVENDA_Name = 'NTO_CODIGOPADRAOVENDA';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOPADRAODEVOLUCAO', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAODEVOLUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAODEVOLUCAO: Integer read FNTO_CODIGOPADRAODEVOLUCAO write FNTO_CODIGOPADRAODEVOLUCAO;
    const NTO_CODIGOPADRAODEVOLUCAO_Name = 'NTO_CODIGOPADRAODEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOPADRAOVENDACPF', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAOVENDACPF', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAOVENDACPF: Integer read FNTO_CODIGOPADRAOVENDACPF write FNTO_CODIGOPADRAOVENDACPF;
    const NTO_CODIGOPADRAOVENDACPF_Name = 'NTO_CODIGOPADRAOVENDACPF';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOPADRAOSERVICO', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAOSERVICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAOSERVICO: Integer read FNTO_CODIGOPADRAOSERVICO write FNTO_CODIGOPADRAOSERVICO;
    const NTO_CODIGOPADRAOSERVICO_Name = 'NTO_CODIGOPADRAOSERVICO';

    [Restrictions([NoValidate])]
    [Column('CFG_REGISTROSINTEGRA', ftString, 30)]
    [Dictionary('CFG_REGISTROSINTEGRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_REGISTROSINTEGRA: String read FCFG_REGISTROSINTEGRA write FCFG_REGISTROSINTEGRA;
    const CFG_REGISTROSINTEGRA_Name = 'CFG_REGISTROSINTEGRA';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALCONTSOCIALMKP', ftBCD, 7667789, 2)]
    [Dictionary('CFG_PERCENTUALCONTSOCIALMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALCONTSOCIALMKP: Double read FCFG_PERCENTUALCONTSOCIALMKP write FCFG_PERCENTUALCONTSOCIALMKP;
    const CFG_PERCENTUALCONTSOCIALMKP_Name = 'CFG_PERCENTUALCONTSOCIALMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALCOMISSAOVNDMKP', ftBCD, 5374019, 2)]
    [Dictionary('CFG_PERCENTUALCOMISSAOVNDMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALCOMISSAOVNDMKP: Double read FCFG_PERCENTUALCOMISSAOVNDMKP write FCFG_PERCENTUALCOMISSAOVNDMKP;
    const CFG_PERCENTUALCOMISSAOVNDMKP_Name = 'CFG_PERCENTUALCOMISSAOVNDMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALIMPOSTORENDAMKP', ftBCD, 6619246, 2)]
    [Dictionary('CFG_PERCENTUALIMPOSTORENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALIMPOSTORENDAMKP: Double read FCFG_PERCENTUALIMPOSTORENDAMKP write FCFG_PERCENTUALIMPOSTORENDAMKP;
    const CFG_PERCENTUALIMPOSTORENDAMKP_Name = 'CFG_PERCENTUALIMPOSTORENDAMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALADMINISTRATIVOMKP', ftBCD, 6357072, 2)]
    [Dictionary('CFG_PERCENTUALADMINISTRATIVOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALADMINISTRATIVOMKP: Double read FCFG_PERCENTUALADMINISTRATIVOMKP write FCFG_PERCENTUALADMINISTRATIVOMKP;
    const CFG_PERCENTUALADMINISTRATIVOMKP_Name = 'CFG_PERCENTUALADMINISTRATIVOMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALSIMPLESMKP_1', ftBCD, 4063332, 2)]
    [Dictionary('CFG_PERCENTUALSIMPLESMKP_1', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALSIMPLESMKP_1: Double read FCFG_PERCENTUALSIMPLESMKP_1 write FCFG_PERCENTUALSIMPLESMKP_1;
    const CFG_PERCENTUALSIMPLESMKP_1_Name = 'CFG_PERCENTUALSIMPLESMKP_1';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALSIMPLESMKP_2', ftBCD, 4063341, 2)]
    [Dictionary('CFG_PERCENTUALSIMPLESMKP_2', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALSIMPLESMKP_2: Double read FCFG_PERCENTUALSIMPLESMKP_2 write FCFG_PERCENTUALSIMPLESMKP_2;
    const CFG_PERCENTUALSIMPLESMKP_2_Name = 'CFG_PERCENTUALSIMPLESMKP_2';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGOPADRAO', ftString, 4)]
    [Dictionary('TDC_CODIGOPADRAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGOPADRAO: String read FTDC_CODIGOPADRAO write FTDC_CODIGOPADRAO;
    const TDC_CODIGOPADRAO_Name = 'TDC_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHEXPORTACAOCOLETOR', ftString, 300)]
    [Dictionary('CFG_PATHEXPORTACAOCOLETOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHEXPORTACAOCOLETOR: String read FCFG_PATHEXPORTACAOCOLETOR write FCFG_PATHEXPORTACAOCOLETOR;
    const CFG_PATHEXPORTACAOCOLETOR_Name = 'CFG_PATHEXPORTACAOCOLETOR';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHEXPORTACAOBALANCA', ftString, 300)]
    [Dictionary('CFG_PATHEXPORTACAOBALANCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHEXPORTACAOBALANCA: String read FCFG_PATHEXPORTACAOBALANCA write FCFG_PATHEXPORTACAOBALANCA;
    const CFG_PATHEXPORTACAOBALANCA_Name = 'CFG_PATHEXPORTACAOBALANCA';

    [Restrictions([NoValidate])]
    [Column('CFG_VRDESCTOARREDONDAMENTOPDV', ftBCD, 6881394, 2)]
    [Dictionary('CFG_VRDESCTOARREDONDAMENTOPDV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VRDESCTOARREDONDAMENTOPDV: Double read FCFG_VRDESCTOARREDONDAMENTOPDV write FCFG_VRDESCTOARREDONDAMENTOPDV;
    const CFG_VRDESCTOARREDONDAMENTOPDV_Name = 'CFG_VRDESCTOARREDONDAMENTOPDV';

    [Restrictions([NoValidate])]
    [Column('CFG_OBSERVACAOEXPORTACAOCNAB_1', ftString, 80)]
    [Dictionary('CFG_OBSERVACAOEXPORTACAOCNAB_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_OBSERVACAOEXPORTACAOCNAB_1: String read FCFG_OBSERVACAOEXPORTACAOCNAB_1 write FCFG_OBSERVACAOEXPORTACAOCNAB_1;
    const CFG_OBSERVACAOEXPORTACAOCNAB_1_Name = 'CFG_OBSERVACAOEXPORTACAOCNAB_1';

    [Restrictions([NoValidate])]
    [Column('CFG_OBSERVACAOEXPORTACAOCNAB_2', ftString, 80)]
    [Dictionary('CFG_OBSERVACAOEXPORTACAOCNAB_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_OBSERVACAOEXPORTACAOCNAB_2: String read FCFG_OBSERVACAOEXPORTACAOCNAB_2 write FCFG_OBSERVACAOEXPORTACAOCNAB_2;
    const CFG_OBSERVACAOEXPORTACAOCNAB_2_Name = 'CFG_OBSERVACAOEXPORTACAOCNAB_2';

    [Restrictions([NoValidate])]
    [Column('CFG_OBSERVACAOEXPORTACAOCNAB_3', ftString, 80)]
    [Dictionary('CFG_OBSERVACAOEXPORTACAOCNAB_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_OBSERVACAOEXPORTACAOCNAB_3: String read FCFG_OBSERVACAOEXPORTACAOCNAB_3 write FCFG_OBSERVACAOEXPORTACAOCNAB_3;
    const CFG_OBSERVACAOEXPORTACAOCNAB_3_Name = 'CFG_OBSERVACAOEXPORTACAOCNAB_3';

    [Restrictions([NoValidate])]
    [Column('CFG_OBSERVACAOEXPORTACAOCNAB_4', ftString, 80)]
    [Dictionary('CFG_OBSERVACAOEXPORTACAOCNAB_4', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_OBSERVACAOEXPORTACAOCNAB_4: String read FCFG_OBSERVACAOEXPORTACAOCNAB_4 write FCFG_OBSERVACAOEXPORTACAOCNAB_4;
    const CFG_OBSERVACAOEXPORTACAOCNAB_4_Name = 'CFG_OBSERVACAOEXPORTACAOCNAB_4';

    [Restrictions([NoValidate])]
    [Column('CFG_OBSERVACAOEXPORTACAOCNAB_5', ftString, 80)]
    [Dictionary('CFG_OBSERVACAOEXPORTACAOCNAB_5', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_OBSERVACAOEXPORTACAOCNAB_5: String read FCFG_OBSERVACAOEXPORTACAOCNAB_5 write FCFG_OBSERVACAOEXPORTACAOCNAB_5;
    const CFG_OBSERVACAOEXPORTACAOCNAB_5_Name = 'CFG_OBSERVACAOEXPORTACAOCNAB_5';

    [Restrictions([NoValidate])]
    [Column('CFG_ORDEMFILTRAPRODUTOS', ftString, 1)]
    [Dictionary('CFG_ORDEMFILTRAPRODUTOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_ORDEMFILTRAPRODUTOS: String read FCFG_ORDEMFILTRAPRODUTOS write FCFG_ORDEMFILTRAPRODUTOS;
    const CFG_ORDEMFILTRAPRODUTOS_Name = 'CFG_ORDEMFILTRAPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOENVIOREGISTROSINTEGRA74', ftString, 1)]
    [Dictionary('CFG_TIPOENVIOREGISTROSINTEGRA74', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOENVIOREGISTROSINTEGRA74: String read FCFG_TIPOENVIOREGISTROSINTEGRA74 write FCFG_TIPOENVIOREGISTROSINTEGRA74;
    const CFG_TIPOENVIOREGISTROSINTEGRA74_Name = 'CFG_TIPOENVIOREGISTROSINTEGRA74';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGOATACADO', ftInteger)]
    [Dictionary('TAB_CODIGOATACADO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGOATACADO: Integer read FTAB_CODIGOATACADO write FTAB_CODIGOATACADO;
    const TAB_CODIGOATACADO_Name = 'TAB_CODIGOATACADO';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHSETTING', ftString, 300)]
    [Dictionary('CFG_PATHSETTING', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHSETTING: String read FCFG_PATHSETTING write FCFG_PATHSETTING;
    const CFG_PATHSETTING_Name = 'CFG_PATHSETTING';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHLOGORELATORIO', ftString, 300)]
    [Dictionary('CFG_PATHLOGORELATORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHLOGORELATORIO: String read FCFG_PATHLOGORELATORIO write FCFG_PATHLOGORELATORIO;
    const CFG_PATHLOGORELATORIO_Name = 'CFG_PATHLOGORELATORIO';

    [Restrictions([NoValidate])]
    [Column('CFG_MODOFUNCIONAMENTO', ftInteger)]
    [Dictionary('CFG_MODOFUNCIONAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_MODOFUNCIONAMENTO: Integer read FCFG_MODOFUNCIONAMENTO write FCFG_MODOFUNCIONAMENTO;
    const CFG_MODOFUNCIONAMENTO_Name = 'CFG_MODOFUNCIONAMENTO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGOPADRAO', ftInteger)]
    [Dictionary('TRP_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGOPADRAO: Integer read FTRP_CODIGOPADRAO write FTRP_CODIGOPADRAO;
    const TRP_CODIGOPADRAO_Name = 'TRP_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILENVIO', ftString, 100)]
    [Dictionary('CFG_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILENVIO: String read FCFG_EMAILENVIO write FCFG_EMAILENVIO;
    const CFG_EMAILENVIO_Name = 'CFG_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('CFG_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILUSUARIOENVIO: String read FCFG_EMAILUSUARIOENVIO write FCFG_EMAILUSUARIOENVIO;
    const CFG_EMAILUSUARIOENVIO_Name = 'CFG_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('CFG_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILSENHAENVIO: String read FCFG_EMAILSENHAENVIO write FCFG_EMAILSENHAENVIO;
    const CFG_EMAILSENHAENVIO_Name = 'CFG_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('CFG_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_EMAILPORTAENVIO: Integer read FCFG_EMAILPORTAENVIO write FCFG_EMAILPORTAENVIO;
    const CFG_EMAILPORTAENVIO_Name = 'CFG_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILSSL', ftString, 1)]
    [Dictionary('CFG_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILSSL: String read FCFG_EMAILSSL write FCFG_EMAILSSL;
    const CFG_EMAILSSL_Name = 'CFG_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILTLS', ftString, 1)]
    [Dictionary('CFG_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILTLS: String read FCFG_EMAILTLS write FCFG_EMAILTLS;
    const CFG_EMAILTLS_Name = 'CFG_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('CFG_MENSAGEMCARTACOBRANCA1', ftString, 5000)]
    [Dictionary('CFG_MENSAGEMCARTACOBRANCA1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_MENSAGEMCARTACOBRANCA1: String read FCFG_MENSAGEMCARTACOBRANCA1 write FCFG_MENSAGEMCARTACOBRANCA1;
    const CFG_MENSAGEMCARTACOBRANCA1_Name = 'CFG_MENSAGEMCARTACOBRANCA1';

    [Restrictions([NoValidate])]
    [Column('CFG_MENSAGEMCARTACOBRANCA2', ftString, 5000)]
    [Dictionary('CFG_MENSAGEMCARTACOBRANCA2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_MENSAGEMCARTACOBRANCA2: String read FCFG_MENSAGEMCARTACOBRANCA2 write FCFG_MENSAGEMCARTACOBRANCA2;
    const CFG_MENSAGEMCARTACOBRANCA2_Name = 'CFG_MENSAGEMCARTACOBRANCA2';

    [Restrictions([NoValidate])]
    [Column('POR_CODIGOPADRAO', ftInteger)]
    [Dictionary('POR_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property POR_CODIGOPADRAO: Integer read FPOR_CODIGOPADRAO write FPOR_CODIGOPADRAO;
    const POR_CODIGOPADRAO_Name = 'POR_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CFG_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('CFG_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILSERVIDORENVIO: String read FCFG_EMAILSERVIDORENVIO write FCFG_EMAILSERVIDORENVIO;
    const CFG_EMAILSERVIDORENVIO_Name = 'CFG_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORTOLERANCIADESCTO', ftBCD, 4522061, 2)]
    [Dictionary('CFG_VALORTOLERANCIADESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORTOLERANCIADESCTO: Double read FCFG_VALORTOLERANCIADESCTO write FCFG_VALORTOLERANCIADESCTO;
    const CFG_VALORTOLERANCIADESCTO_Name = 'CFG_VALORTOLERANCIADESCTO';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORMINIMOPARCELAMENTO', ftBCD, 3932209, 2)]
    [Dictionary('CFG_VALORMINIMOPARCELAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORMINIMOPARCELAMENTO: Double read FCFG_VALORMINIMOPARCELAMENTO write FCFG_VALORMINIMOPARCELAMENTO;
    const CFG_VALORMINIMOPARCELAMENTO_Name = 'CFG_VALORMINIMOPARCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFG_MARKUPMINVENDA', ftBCD, 4063340, 2)]
    [Dictionary('CFG_MARKUPMINVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_MARKUPMINVENDA: Double read FCFG_MARKUPMINVENDA write FCFG_MARKUPMINVENDA;
    const CFG_MARKUPMINVENDA_Name = 'CFG_MARKUPMINVENDA';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGOPADRAO', ftInteger)]
    [Dictionary('GRP_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGOPADRAO: Integer read FGRP_CODIGOPADRAO write FGRP_CODIGOPADRAO;
    const GRP_CODIGOPADRAO_Name = 'GRP_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGOPADRAO', ftInteger)]
    [Dictionary('SGP_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGOPADRAO: Integer read FSGP_CODIGOPADRAO write FSGP_CODIGOPADRAO;
    const SGP_CODIGOPADRAO_Name = 'SGP_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOIMPRESSAODOCTOBOLETO', ftString, 1)]
    [Dictionary('CFG_TIPOIMPRESSAODOCTOBOLETO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOIMPRESSAODOCTOBOLETO: String read FCFG_TIPOIMPRESSAODOCTOBOLETO write FCFG_TIPOIMPRESSAODOCTOBOLETO;
    const CFG_TIPOIMPRESSAODOCTOBOLETO_Name = 'CFG_TIPOIMPRESSAODOCTOBOLETO';

    [Restrictions([NoValidate])]
    [Column('CFG_IBPTCHAVE', ftString, 10)]
    [Dictionary('CFG_IBPTCHAVE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IBPTCHAVE: String read FCFG_IBPTCHAVE write FCFG_IBPTCHAVE;
    const CFG_IBPTCHAVE_Name = 'CFG_IBPTCHAVE';

    [Restrictions([NoValidate])]
    [Column('CFG_IBPTVERSAO', ftString, 10)]
    [Dictionary('CFG_IBPTVERSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IBPTVERSAO: String read FCFG_IBPTVERSAO write FCFG_IBPTVERSAO;
    const CFG_IBPTVERSAO_Name = 'CFG_IBPTVERSAO';

    [Restrictions([NoValidate])]
    [Column('CFG_QTDCASADECIMALVALORUNITARIO', ftInteger)]
    [Dictionary('CFG_QTDCASADECIMALVALORUNITARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_QTDCASADECIMALVALORUNITARIO: Integer read FCFG_QTDCASADECIMALVALORUNITARIO write FCFG_QTDCASADECIMALVALORUNITARIO;
    const CFG_QTDCASADECIMALVALORUNITARIO_Name = 'CFG_QTDCASADECIMALVALORUNITARIO';

    [Restrictions([NoValidate])]
    [Column('CFG_QTDCASADECIMALQUANTIDADE', ftInteger)]
    [Dictionary('CFG_QTDCASADECIMALQUANTIDADE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_QTDCASADECIMALQUANTIDADE: Integer read FCFG_QTDCASADECIMALQUANTIDADE write FCFG_QTDCASADECIMALQUANTIDADE;
    const CFG_QTDCASADECIMALQUANTIDADE_Name = 'CFG_QTDCASADECIMALQUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('CFG_CONFIGURACAOIMPRESSAOVENDA', ftString, 1)]
    [Dictionary('CFG_CONFIGURACAOIMPRESSAOVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CONFIGURACAOIMPRESSAOVENDA: String read FCFG_CONFIGURACAOIMPRESSAOVENDA write FCFG_CONFIGURACAOIMPRESSAOVENDA;
    const CFG_CONFIGURACAOIMPRESSAOVENDA_Name = 'CFG_CONFIGURACAOIMPRESSAOVENDA';

    [Restrictions([NoValidate])]
    [Column('CFG_SENHALIBERACAOVENDA', ftString, 15)]
    [Dictionary('CFG_SENHALIBERACAOVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_SENHALIBERACAOVENDA: String read FCFG_SENHALIBERACAOVENDA write FCFG_SENHALIBERACAOVENDA;
    const CFG_SENHALIBERACAOVENDA_Name = 'CFG_SENHALIBERACAOVENDA';

    [Restrictions([NoValidate])]
    [Column('CFG_ESTOQUERESERVASAIDA', ftString, 1)]
    [Dictionary('CFG_ESTOQUERESERVASAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_ESTOQUERESERVASAIDA: String read FCFG_ESTOQUERESERVASAIDA write FCFG_ESTOQUERESERVASAIDA;
    const CFG_ESTOQUERESERVASAIDA_Name = 'CFG_ESTOQUERESERVASAIDA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOPADRAOANTECIPACAOFOR', ftInteger)]
    [Dictionary('CTA_CODIGOPADRAOANTECIPACAOFOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOPADRAOANTECIPACAOFOR: Integer read FCTA_CODIGOPADRAOANTECIPACAOFOR write FCTA_CODIGOPADRAOANTECIPACAOFOR;
    const CTA_CODIGOPADRAOANTECIPACAOFOR_Name = 'CTA_CODIGOPADRAOANTECIPACAOFOR';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOPADRAOANTECIPACAOCLI', ftInteger)]
    [Dictionary('CTA_CODIGOPADRAOANTECIPACAOCLI', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOPADRAOANTECIPACAOCLI: Integer read FCTA_CODIGOPADRAOANTECIPACAOCLI write FCTA_CODIGOPADRAOANTECIPACAOCLI;
    const CTA_CODIGOPADRAOANTECIPACAOCLI_Name = 'CTA_CODIGOPADRAOANTECIPACAOCLI';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOFRETE', ftString, 1)]
    [Dictionary('CFG_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOFRETE: String read FCFG_TIPOFRETE write FCFG_TIPOFRETE;
    const CFG_TIPOFRETE_Name = 'CFG_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO_CTR', ftString, 4)]
    [Dictionary('CFOP_CODIGO_CTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO_CTR: String read FCFOP_CODIGO_CTR write FCFOP_CODIGO_CTR;
    const CFOP_CODIGO_CTR_Name = 'CFOP_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO_CTR', ftString, 2)]
    [Dictionary('MNF_CODIGO_CTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO_CTR: String read FMNF_CODIGO_CTR write FMNF_CODIGO_CTR;
    const MNF_CODIGO_CTR_Name = 'MNF_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO_CTR', ftInteger)]
    [Dictionary('PES_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO_CTR: Integer read FPES_CODIGO_CTR write FPES_CODIGO_CTR;
    const PES_CODIGO_CTR_Name = 'PES_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO_CTR', ftInteger)]
    [Dictionary('PLC_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO_CTR: Integer read FPLC_CODIGO_CTR write FPLC_CODIGO_CTR;
    const PLC_CODIGO_CTR_Name = 'PLC_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO_CTR', ftInteger)]
    [Dictionary('CCU_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO_CTR: Integer read FCCU_CODIGO_CTR write FCCU_CODIGO_CTR;
    const CCU_CODIGO_CTR_Name = 'CCU_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO_CTR', ftString, 3)]
    [Dictionary('TDC_CODIGO_CTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO_CTR: String read FTDC_CODIGO_CTR write FTDC_CODIGO_CTR;
    const TDC_CODIGO_CTR_Name = 'TDC_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_SUBSERIE', ftString, 2)]
    [Dictionary('CTR_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SUBSERIE: String read FCTR_SUBSERIE write FCTR_SUBSERIE;
    const CTR_SUBSERIE_Name = 'CTR_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZA', ftString, 20)]
    [Dictionary('CTR_NATUREZA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZA: String read FCTR_NATUREZA write FCTR_NATUREZA;
    const CTR_NATUREZA_Name = 'CTR_NATUREZA';

    [Restrictions([NoValidate])]
    [Column('CTR_ESPECIE', ftString, 15)]
    [Dictionary('CTR_ESPECIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ESPECIE: String read FCTR_ESPECIE write FCTR_ESPECIE;
    const CTR_ESPECIE_Name = 'CTR_ESPECIE';

    [Restrictions([NoValidate])]
    [Column('CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO: String read FCTR_OBSERVACAO write FCTR_OBSERVACAO;
    const CTR_OBSERVACAO_Name = 'CTR_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZACARGA', ftString, 15)]
    [Dictionary('CTR_NATUREZACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZACARGA: String read FCTR_NATUREZACARGA write FCTR_NATUREZACARGA;
    const CTR_NATUREZACARGA_Name = 'CTR_NATUREZACARGA';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALICMS', ftBCD, 7798857, 2)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('CTR_CONFIGURACOES', ftString, 100)]
    [Dictionary('CTR_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CONFIGURACOES: String read FCTR_CONFIGURACOES write FCTR_CONFIGURACOES;
    const CTR_CONFIGURACOES_Name = 'CTR_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('CTR_APOLICE', ftString, 15)]
    [Dictionary('CTR_APOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_APOLICE: String read FCTR_APOLICE write FCTR_APOLICE;
    const CTR_APOLICE_Name = 'CTR_APOLICE';

    [Restrictions([NoValidate])]
    [Column('CTR_COBRADORA', ftString, 15)]
    [Dictionary('CTR_COBRADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_COBRADORA: String read FCTR_COBRADORA write FCTR_COBRADORA;
    const CTR_COBRADORA_Name = 'CTR_COBRADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_FINALIDADE', ftString, 1)]
    [Dictionary('CTR_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_FINALIDADE: String read FCTR_FINALIDADE write FCTR_FINALIDADE;
    const CTR_FINALIDADE_Name = 'CTR_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOEMISSAO', ftString, 1)]
    [Dictionary('CTR_TIPOEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOEMISSAO: String read FCTR_TIPOEMISSAO write FCTR_TIPOEMISSAO;
    const CTR_TIPOEMISSAO_Name = 'CTR_TIPOEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTR_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('CTR_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AMBIENTEENVIO: String read FCTR_AMBIENTEENVIO write FCTR_AMBIENTEENVIO;
    const CTR_AMBIENTEENVIO_Name = 'CTR_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPODACTE', ftString, 1)]
    [Dictionary('CTR_TIPODACTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPODACTE: String read FCTR_TIPODACTE write FCTR_TIPODACTE;
    const CTR_TIPODACTE_Name = 'CTR_TIPODACTE';

    [Restrictions([NoValidate])]
    [Column('CTR_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('CTR_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CERTIFICADONUMEROSERIE: String read FCTR_CERTIFICADONUMEROSERIE write FCTR_CERTIFICADONUMEROSERIE;
    const CTR_CERTIFICADONUMEROSERIE_Name = 'CTR_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('CTR_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CERTIFICADOSENHA: String read FCTR_CERTIFICADOSENHA write FCTR_CERTIFICADOSENHA;
    const CTR_CERTIFICADOSENHA_Name = 'CTR_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('CTR_SSLLIB', ftString, 1)]
    [Dictionary('CTR_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SSLLIB: String read FCTR_SSLLIB write FCTR_SSLLIB;
    const CTR_SSLLIB_Name = 'CTR_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('CTR_UFDESTINO', ftString, 2)]
    [Dictionary('CTR_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UFDESTINO: String read FCTR_UFDESTINO write FCTR_UFDESTINO;
    const CTR_UFDESTINO_Name = 'CTR_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYHOST', ftString, 50)]
    [Dictionary('CTR_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROXYHOST: String read FCTR_PROXYHOST write FCTR_PROXYHOST;
    const CTR_PROXYHOST_Name = 'CTR_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYPORTA', ftInteger)]
    [Dictionary('CTR_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_PROXYPORTA: Integer read FCTR_PROXYPORTA write FCTR_PROXYPORTA;
    const CTR_PROXYPORTA_Name = 'CTR_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYUSUARIO', ftString, 50)]
    [Dictionary('CTR_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROXYUSUARIO: String read FCTR_PROXYUSUARIO write FCTR_PROXYUSUARIO;
    const CTR_PROXYUSUARIO_Name = 'CTR_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYSENHA', ftString, 25)]
    [Dictionary('CTR_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROXYSENHA: String read FCTR_PROXYSENHA write FCTR_PROXYSENHA;
    const CTR_PROXYSENHA_Name = 'CTR_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('CTR_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHLOGOMARCA: String read FCTR_PATHLOGOMARCA write FCTR_PATHLOGOMARCA;
    const CTR_PATHLOGOMARCA_Name = 'CTR_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHSCHEMA', ftString, 255)]
    [Dictionary('CTR_PATHSCHEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHSCHEMA: String read FCTR_PATHSCHEMA write FCTR_PATHSCHEMA;
    const CTR_PATHSCHEMA_Name = 'CTR_PATHSCHEMA';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('CTR_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHREPOSITORIO: String read FCTR_PATHREPOSITORIO write FCTR_PATHREPOSITORIO;
    const CTR_PATHREPOSITORIO_Name = 'CTR_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('CTR_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHARQENVIORESPOSTA: String read FCTR_PATHARQENVIORESPOSTA write FCTR_PATHARQENVIORESPOSTA;
    const CTR_PATHARQENVIORESPOSTA_Name = 'CTR_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('CTR_ATUALIZARCTEINICIAR', ftString, 1)]
    [Dictionary('CTR_ATUALIZARCTEINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ATUALIZARCTEINICIAR: String read FCTR_ATUALIZARCTEINICIAR write FCTR_ATUALIZARCTEINICIAR;
    const CTR_ATUALIZARCTEINICIAR_Name = 'CTR_ATUALIZARCTEINICIAR';

    [Restrictions([NoValidate])]
    [Column('CTR_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('CTR_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ENVIAREMAILAPOSAUTORIZACAO: String read FCTR_ENVIAREMAILAPOSAUTORIZACAO write FCTR_ENVIAREMAILAPOSAUTORIZACAO;
    const CTR_ENVIAREMAILAPOSAUTORIZACAO_Name = 'CTR_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOMEIOTRANSPORTE', ftString, 4)]
    [Dictionary('CTR_TIPOMEIOTRANSPORTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOMEIOTRANSPORTE: String read FCTR_TIPOMEIOTRANSPORTE write FCTR_TIPOMEIOTRANSPORTE;
    const CTR_TIPOMEIOTRANSPORTE_Name = 'CTR_TIPOMEIOTRANSPORTE';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIECONTIGENCIA', ftString, 3)]
    [Dictionary('CTR_SERIECONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIECONTIGENCIA: String read FCTR_SERIECONTIGENCIA write FCTR_SERIECONTIGENCIA;
    const CTR_SERIECONTIGENCIA_Name = 'CTR_SERIECONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTR_CONTRATORODOVIARIOCPA', ftString, 1)]
    [Dictionary('CTR_CONTRATORODOVIARIOCPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CONTRATORODOVIARIOCPA: String read FCTR_CONTRATORODOVIARIOCPA write FCTR_CONTRATORODOVIARIOCPA;
    const CTR_CONTRATORODOVIARIOCPA_Name = 'CTR_CONTRATORODOVIARIOCPA';

    [Restrictions([NoValidate])]
    [Column('CTR_MANIFESTOCARGACPA', ftString, 1)]
    [Dictionary('CTR_MANIFESTOCARGACPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_MANIFESTOCARGACPA: String read FCTR_MANIFESTOCARGACPA write FCTR_MANIFESTOCARGACPA;
    const CTR_MANIFESTOCARGACPA_Name = 'CTR_MANIFESTOCARGACPA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO_CTR', ftInteger)]
    [Dictionary('PRO_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO_CTR: Integer read FPRO_CODIGO_CTR write FPRO_CODIGO_CTR;
    const PRO_CODIGO_CTR_Name = 'PRO_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO_CTR', ftInteger)]
    [Dictionary('FOR_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO_CTR: Integer read FFOR_CODIGO_CTR write FFOR_CODIGO_CTR;
    const FOR_CODIGO_CTR_Name = 'FOR_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('CTR_RNTRC', ftString, 14)]
    [Dictionary('CTR_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_RNTRC: String read FCTR_RNTRC write FCTR_RNTRC;
    const CTR_RNTRC_Name = 'CTR_RNTRC';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO_CTR', ftInteger)]
    [Dictionary('NTO_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO_CTR: Integer read FNTO_CODIGO_CTR write FNTO_CODIGO_CTR;
    const NTO_CODIGO_CTR_Name = 'NTO_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO_CTR', ftInteger)]
    [Dictionary('PRZ_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO_CTR: Integer read FPRZ_CODIGO_CTR write FPRZ_CODIGO_CTR;
    const PRZ_CODIGO_CTR_Name = 'PRZ_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO_CTR', ftInteger)]
    [Dictionary('FPG_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO_CTR: Integer read FFPG_CODIGO_CTR write FFPG_CODIGO_CTR;
    const FPG_CODIGO_CTR_Name = 'FPG_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO_CTR', ftInteger)]
    [Dictionary('LEF_CODIGO_CTR', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO_CTR: Integer read FLEF_CODIGO_CTR write FLEF_CODIGO_CTR;
    const LEF_CODIGO_CTR_Name = 'LEF_CODIGO_CTR';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('CTR_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILSERVIDORENVIO: String read FCTR_EMAILSERVIDORENVIO write FCTR_EMAILSERVIDORENVIO;
    const CTR_EMAILSERVIDORENVIO_Name = 'CTR_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILENVIO', ftString, 100)]
    [Dictionary('CTR_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILENVIO: String read FCTR_EMAILENVIO write FCTR_EMAILENVIO;
    const CTR_EMAILENVIO_Name = 'CTR_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('CTR_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILUSUARIOENVIO: String read FCTR_EMAILUSUARIOENVIO write FCTR_EMAILUSUARIOENVIO;
    const CTR_EMAILUSUARIOENVIO_Name = 'CTR_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('CTR_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILSENHAENVIO: String read FCTR_EMAILSENHAENVIO write FCTR_EMAILSENHAENVIO;
    const CTR_EMAILSENHAENVIO_Name = 'CTR_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('CTR_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_EMAILPORTAENVIO: Integer read FCTR_EMAILPORTAENVIO write FCTR_EMAILPORTAENVIO;
    const CTR_EMAILPORTAENVIO_Name = 'CTR_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILSSL', ftString, 1)]
    [Dictionary('CTR_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILSSL: String read FCTR_EMAILSSL write FCTR_EMAILSSL;
    const CTR_EMAILSSL_Name = 'CTR_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILTLS', ftString, 1)]
    [Dictionary('CTR_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILTLS: String read FCTR_EMAILTLS write FCTR_EMAILTLS;
    const CTR_EMAILTLS_Name = 'CTR_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMISSAO', ftString, 1)]
    [Dictionary('MFC_TIPOEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMISSAO: String read FMFC_TIPOEMISSAO write FMFC_TIPOEMISSAO;
    const MFC_TIPOEMISSAO_Name = 'MFC_TIPOEMISSAO';

    [Restrictions([NoValidate])]
    [Column('MFC_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('MFC_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_AMBIENTEENVIO: String read FMFC_AMBIENTEENVIO write FMFC_AMBIENTEENVIO;
    const MFC_AMBIENTEENVIO_Name = 'MFC_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPODACTE', ftString, 1)]
    [Dictionary('MFC_TIPODACTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPODACTE: String read FMFC_TIPODACTE write FMFC_TIPODACTE;
    const MFC_TIPODACTE_Name = 'MFC_TIPODACTE';

    [Restrictions([NoValidate])]
    [Column('MFC_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('MFC_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CERTIFICADONUMEROSERIE: String read FMFC_CERTIFICADONUMEROSERIE write FMFC_CERTIFICADONUMEROSERIE;
    const MFC_CERTIFICADONUMEROSERIE_Name = 'MFC_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('MFC_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CERTIFICADOSENHA: String read FMFC_CERTIFICADOSENHA write FMFC_CERTIFICADOSENHA;
    const MFC_CERTIFICADOSENHA_Name = 'MFC_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('MFC_SSLLIB', ftString, 1)]
    [Dictionary('MFC_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SSLLIB: String read FMFC_SSLLIB write FMFC_SSLLIB;
    const MFC_SSLLIB_Name = 'MFC_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('MFC_UFDESTINO', ftString, 2)]
    [Dictionary('MFC_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UFDESTINO: String read FMFC_UFDESTINO write FMFC_UFDESTINO;
    const MFC_UFDESTINO_Name = 'MFC_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYHOST', ftString, 50)]
    [Dictionary('MFC_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROXYHOST: String read FMFC_PROXYHOST write FMFC_PROXYHOST;
    const MFC_PROXYHOST_Name = 'MFC_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYPORTA', ftInteger)]
    [Dictionary('MFC_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_PROXYPORTA: Integer read FMFC_PROXYPORTA write FMFC_PROXYPORTA;
    const MFC_PROXYPORTA_Name = 'MFC_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYUSUARIO', ftString, 50)]
    [Dictionary('MFC_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROXYUSUARIO: String read FMFC_PROXYUSUARIO write FMFC_PROXYUSUARIO;
    const MFC_PROXYUSUARIO_Name = 'MFC_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYSENHA', ftString, 25)]
    [Dictionary('MFC_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROXYSENHA: String read FMFC_PROXYSENHA write FMFC_PROXYSENHA;
    const MFC_PROXYSENHA_Name = 'MFC_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('MFC_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHLOGOMARCA: String read FMFC_PATHLOGOMARCA write FMFC_PATHLOGOMARCA;
    const MFC_PATHLOGOMARCA_Name = 'MFC_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHSCHEMA', ftString, 255)]
    [Dictionary('MFC_PATHSCHEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHSCHEMA: String read FMFC_PATHSCHEMA write FMFC_PATHSCHEMA;
    const MFC_PATHSCHEMA_Name = 'MFC_PATHSCHEMA';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('MFC_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHREPOSITORIO: String read FMFC_PATHREPOSITORIO write FMFC_PATHREPOSITORIO;
    const MFC_PATHREPOSITORIO_Name = 'MFC_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('MFC_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHARQENVIORESPOSTA: String read FMFC_PATHARQENVIORESPOSTA write FMFC_PATHARQENVIORESPOSTA;
    const MFC_PATHARQENVIORESPOSTA_Name = 'MFC_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('MFC_ATUALIZARCTEINICIAR', ftString, 1)]
    [Dictionary('MFC_ATUALIZARCTEINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_ATUALIZARCTEINICIAR: String read FMFC_ATUALIZARCTEINICIAR write FMFC_ATUALIZARCTEINICIAR;
    const MFC_ATUALIZARCTEINICIAR_Name = 'MFC_ATUALIZARCTEINICIAR';

    [Restrictions([NoValidate])]
    [Column('MFC_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('MFC_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_ENVIAREMAILAPOSAUTORIZACAO: String read FMFC_ENVIAREMAILAPOSAUTORIZACAO write FMFC_ENVIAREMAILAPOSAUTORIZACAO;
    const MFC_ENVIAREMAILAPOSAUTORIZACAO_Name = 'MFC_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('MFC_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILSERVIDORENVIO: String read FMFC_EMAILSERVIDORENVIO write FMFC_EMAILSERVIDORENVIO;
    const MFC_EMAILSERVIDORENVIO_Name = 'MFC_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILENVIO', ftString, 100)]
    [Dictionary('MFC_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILENVIO: String read FMFC_EMAILENVIO write FMFC_EMAILENVIO;
    const MFC_EMAILENVIO_Name = 'MFC_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('MFC_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILUSUARIOENVIO: String read FMFC_EMAILUSUARIOENVIO write FMFC_EMAILUSUARIOENVIO;
    const MFC_EMAILUSUARIOENVIO_Name = 'MFC_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('MFC_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILSENHAENVIO: String read FMFC_EMAILSENHAENVIO write FMFC_EMAILSENHAENVIO;
    const MFC_EMAILSENHAENVIO_Name = 'MFC_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('MFC_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_EMAILPORTAENVIO: Integer read FMFC_EMAILPORTAENVIO write FMFC_EMAILPORTAENVIO;
    const MFC_EMAILPORTAENVIO_Name = 'MFC_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILSSL', ftString, 1)]
    [Dictionary('MFC_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILSSL: String read FMFC_EMAILSSL write FMFC_EMAILSSL;
    const MFC_EMAILSSL_Name = 'MFC_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILTLS', ftString, 1)]
    [Dictionary('MFC_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILTLS: String read FMFC_EMAILTLS write FMFC_EMAILTLS;
    const MFC_EMAILTLS_Name = 'MFC_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO_MFC', ftString, 2)]
    [Dictionary('MNF_CODIGO_MFC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO_MFC: String read FMNF_CODIGO_MFC write FMNF_CODIGO_MFC;
    const MNF_CODIGO_MFC_Name = 'MNF_CODIGO_MFC';

    [Restrictions([NoValidate])]
    [Column('MFC_SERIE', ftString, 3)]
    [Dictionary('MFC_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SERIE: String read FMFC_SERIE write FMFC_SERIE;
    const MFC_SERIE_Name = 'MFC_SERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_SUBSERIE', ftString, 2)]
    [Dictionary('MFC_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SUBSERIE: String read FMFC_SUBSERIE write FMFC_SUBSERIE;
    const MFC_SUBSERIE_Name = 'MFC_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_SERIECONTIGENCIA', ftString, 3)]
    [Dictionary('MFC_SERIECONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SERIECONTIGENCIA: String read FMFC_SERIECONTIGENCIA write FMFC_SERIECONTIGENCIA;
    const MFC_SERIECONTIGENCIA_Name = 'MFC_SERIECONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPT', ftBCD, 4653161, 2)]
    [Dictionary('CTR_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPT: Double read FCTR_PERCENTUALIBPT write FCTR_PERCENTUALIBPT;
    const CTR_PERCENTUALIBPT_Name = 'CTR_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOFRETE', ftString, 1)]
    [Dictionary('CTR_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOFRETE: String read FCTR_TIPOFRETE write FCTR_TIPOFRETE;
    const CTR_TIPOFRETE_Name = 'CTR_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPTESTADUAL', ftBCD, 5177396, 2)]
    [Dictionary('CTR_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPTESTADUAL: Double read FCTR_PERCENTUALIBPTESTADUAL write FCTR_PERCENTUALIBPTESTADUAL;
    const CTR_PERCENTUALIBPTESTADUAL_Name = 'CTR_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPTNACIONAL', ftBCD, 3407984, 2)]
    [Dictionary('CTR_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPTNACIONAL: Double read FCTR_PERCENTUALIBPTNACIONAL write FCTR_PERCENTUALIBPTNACIONAL;
    const CTR_PERCENTUALIBPTNACIONAL_Name = 'CTR_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMITENTE', ftString, 1)]
    [Dictionary('MFC_TIPOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMITENTE: String read FMFC_TIPOEMITENTE write FMFC_TIPOEMITENTE;
    const MFC_TIPOEMITENTE_Name = 'MFC_TIPOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTR_GLOBALIZADO', ftString, 1)]
    [Dictionary('CTR_GLOBALIZADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_GLOBALIZADO: String read FCTR_GLOBALIZADO write FCTR_GLOBALIZADO;
    const CTR_GLOBALIZADO_Name = 'CTR_GLOBALIZADO';

    [Restrictions([NoValidate])]
    [Column('CTR_USUARIOAPISEGURADORA', ftString, 50)]
    [Dictionary('CTR_USUARIOAPISEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_USUARIOAPISEGURADORA: String read FCTR_USUARIOAPISEGURADORA write FCTR_USUARIOAPISEGURADORA;
    const CTR_USUARIOAPISEGURADORA_Name = 'CTR_USUARIOAPISEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_SENHAAPISEGURADORA', ftString, 25)]
    [Dictionary('CTR_SENHAAPISEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SENHAAPISEGURADORA: String read FCTR_SENHAAPISEGURADORA write FCTR_SENHAAPISEGURADORA;
    const CTR_SENHAAPISEGURADORA_Name = 'CTR_SENHAAPISEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_CODIGOAPISEGURADORA', ftString, 15)]
    [Dictionary('CTR_CODIGOAPISEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CODIGOAPISEGURADORA: String read FCTR_CODIGOAPISEGURADORA write FCTR_CODIGOAPISEGURADORA;
    const CTR_CODIGOAPISEGURADORA_Name = 'CTR_CODIGOAPISEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_AVERBARAUTOMATICAMENTE', ftString, 1)]
    [Dictionary('CTR_AVERBARAUTOMATICAMENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AVERBARAUTOMATICAMENTE: String read FCTR_AVERBARAUTOMATICAMENTE write FCTR_AVERBARAUTOMATICAMENTE;
    const CTR_AVERBARAUTOMATICAMENTE_Name = 'CTR_AVERBARAUTOMATICAMENTE';

    [Restrictions([NoValidate])]
    [Column('MFC_DECLARARAUTOMATICAMENTE', ftString, 1)]
    [Dictionary('MFC_DECLARARAUTOMATICAMENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_DECLARARAUTOMATICAMENTE: String read FMFC_DECLARARAUTOMATICAMENTE write FMFC_DECLARARAUTOMATICAMENTE;
    const MFC_DECLARARAUTOMATICAMENTE_Name = 'MFC_DECLARARAUTOMATICAMENTE';

    [Restrictions([NoValidate])]
    [Column('NFE_FINALIDADE', ftString, 1)]
    [Dictionary('NFE_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_FINALIDADE: String read FNFE_FINALIDADE write FNFE_FINALIDADE;
    const NFE_FINALIDADE_Name = 'NFE_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPOEMISSAO', ftString, 1)]
    [Dictionary('NFE_TIPOEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOEMISSAO: String read FNFE_TIPOEMISSAO write FNFE_TIPOEMISSAO;
    const NFE_TIPOEMISSAO_Name = 'NFE_TIPOEMISSAO';

    [Restrictions([NoValidate])]
    [Column('NFE_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('NFE_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_AMBIENTEENVIO: String read FNFE_AMBIENTEENVIO write FNFE_AMBIENTEENVIO;
    const NFE_AMBIENTEENVIO_Name = 'NFE_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHEXPORTACAO', ftString, 600)]
    [Dictionary('NFE_PATHEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHEXPORTACAO: String read FNFE_PATHEXPORTACAO write FNFE_PATHEXPORTACAO;
    const NFE_PATHEXPORTACAO_Name = 'NFE_PATHEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHIMPORTACAO', ftString, 255)]
    [Dictionary('NFE_PATHIMPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHIMPORTACAO: String read FNFE_PATHIMPORTACAO write FNFE_PATHIMPORTACAO;
    const NFE_PATHIMPORTACAO_Name = 'NFE_PATHIMPORTACAO';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALCDICMSSIMPLES', ftBCD, 18, 4)]
    [Dictionary('CFG_PERCENTUALCDICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALCDICMSSIMPLES: Double read FCFG_PERCENTUALCDICMSSIMPLES write FCFG_PERCENTUALCDICMSSIMPLES;
    const CFG_PERCENTUALCDICMSSIMPLES_Name = 'CFG_PERCENTUALCDICMSSIMPLES';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPODANFE', ftString, 1)]
    [Dictionary('NFE_TIPODANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPODANFE: String read FNFE_TIPODANFE write FNFE_TIPODANFE;
    const NFE_TIPODANFE_Name = 'NFE_TIPODANFE';

    [Restrictions([NoValidate])]
    [Column('NFE_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('NFE_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CERTIFICADONUMEROSERIE: String read FNFE_CERTIFICADONUMEROSERIE write FNFE_CERTIFICADONUMEROSERIE;
    const NFE_CERTIFICADONUMEROSERIE_Name = 'NFE_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('NFE_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('NFE_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CERTIFICADOSENHA: String read FNFE_CERTIFICADOSENHA write FNFE_CERTIFICADOSENHA;
    const NFE_CERTIFICADOSENHA_Name = 'NFE_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('NFE_SSLLIB', ftString, 1)]
    [Dictionary('NFE_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SSLLIB: String read FNFE_SSLLIB write FNFE_SSLLIB;
    const NFE_SSLLIB_Name = 'NFE_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('NFE_UFDESTINO', ftString, 2)]
    [Dictionary('NFE_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_UFDESTINO: String read FNFE_UFDESTINO write FNFE_UFDESTINO;
    const NFE_UFDESTINO_Name = 'NFE_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYHOST', ftString, 50)]
    [Dictionary('NFE_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROXYHOST: String read FNFE_PROXYHOST write FNFE_PROXYHOST;
    const NFE_PROXYHOST_Name = 'NFE_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYPORTA', ftInteger)]
    [Dictionary('NFE_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_PROXYPORTA: Integer read FNFE_PROXYPORTA write FNFE_PROXYPORTA;
    const NFE_PROXYPORTA_Name = 'NFE_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYUSUARIO', ftString, 50)]
    [Dictionary('NFE_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROXYUSUARIO: String read FNFE_PROXYUSUARIO write FNFE_PROXYUSUARIO;
    const NFE_PROXYUSUARIO_Name = 'NFE_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYSENHA', ftString, 25)]
    [Dictionary('NFE_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROXYSENHA: String read FNFE_PROXYSENHA write FNFE_PROXYSENHA;
    const NFE_PROXYSENHA_Name = 'NFE_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('NFE_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHLOGOMARCA: String read FNFE_PATHLOGOMARCA write FNFE_PATHLOGOMARCA;
    const NFE_PATHLOGOMARCA_Name = 'NFE_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHSCHEMA', ftString, 255)]
    [Dictionary('NFE_PATHSCHEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHSCHEMA: String read FNFE_PATHSCHEMA write FNFE_PATHSCHEMA;
    const NFE_PATHSCHEMA_Name = 'NFE_PATHSCHEMA';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('NFE_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHREPOSITORIO: String read FNFE_PATHREPOSITORIO write FNFE_PATHREPOSITORIO;
    const NFE_PATHREPOSITORIO_Name = 'NFE_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('NFE_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHARQENVIORESPOSTA: String read FNFE_PATHARQENVIORESPOSTA write FNFE_PATHARQENVIORESPOSTA;
    const NFE_PATHARQENVIORESPOSTA_Name = 'NFE_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('NFE_ATUALIZARNOTASINICIAR', ftString, 1)]
    [Dictionary('NFE_ATUALIZARNOTASINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ATUALIZARNOTASINICIAR: String read FNFE_ATUALIZARNOTASINICIAR write FNFE_ATUALIZARNOTASINICIAR;
    const NFE_ATUALIZARNOTASINICIAR_Name = 'NFE_ATUALIZARNOTASINICIAR';

    [Restrictions([NoValidate])]
    [Column('NFE_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('NFE_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ENVIAREMAILAPOSAUTORIZACAO: String read FNFE_ENVIAREMAILAPOSAUTORIZACAO write FNFE_ENVIAREMAILAPOSAUTORIZACAO;
    const NFE_ENVIAREMAILAPOSAUTORIZACAO_Name = 'NFE_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAOSAIDA', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAOSAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAOSAIDA: String read FMNF_CODIGOPADRAOSAIDA write FMNF_CODIGOPADRAOSAIDA;
    const MNF_CODIGOPADRAOSAIDA_Name = 'MNF_CODIGOPADRAOSAIDA';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAOENTRADA', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAOENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAOENTRADA: String read FMNF_CODIGOPADRAOENTRADA write FMNF_CODIGOPADRAOENTRADA;
    const MNF_CODIGOPADRAOENTRADA_Name = 'MNF_CODIGOPADRAOENTRADA';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAONFC', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAONFC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAONFC: String read FMNF_CODIGOPADRAONFC write FMNF_CODIGOPADRAONFC;
    const MNF_CODIGOPADRAONFC_Name = 'MNF_CODIGOPADRAONFC';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIENFE', ftString, 3)]
    [Dictionary('NFE_SERIENFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIENFE: String read FNFE_SERIENFE write FNFE_SERIENFE;
    const NFE_SERIENFE_Name = 'NFE_SERIENFE';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIENFC', ftString, 3)]
    [Dictionary('NFE_SERIENFC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIENFC: String read FNFE_SERIENFC write FNFE_SERIENFC;
    const NFE_SERIENFC_Name = 'NFE_SERIENFC';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIENFECONTIGENCIA', ftString, 3)]
    [Dictionary('NFE_SERIENFECONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIENFECONTIGENCIA: String read FNFE_SERIENFECONTIGENCIA write FNFE_SERIENFECONTIGENCIA;
    const NFE_SERIENFECONTIGENCIA_Name = 'NFE_SERIENFECONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('NFE_ESPECIE', ftString, 30)]
    [Dictionary('NFE_ESPECIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ESPECIE: String read FNFE_ESPECIE write FNFE_ESPECIE;
    const NFE_ESPECIE_Name = 'NFE_ESPECIE';

    [Restrictions([NoValidate])]
    [Column('NFE_MARCA', ftString, 30)]
    [Dictionary('NFE_MARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MARCA: String read FNFE_MARCA write FNFE_MARCA;
    const NFE_MARCA_Name = 'NFE_MARCA';

    [Restrictions([NoValidate])]
    [Column('NFSE_SERIESERVICO', ftString, 3)]
    [Dictionary('NFSE_SERIESERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_SERIESERVICO: String read FNFSE_SERIESERVICO write FNFSE_SERIESERVICO;
    const NFSE_SERIESERVICO_Name = 'NFSE_SERIESERVICO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAOSERVICO', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAOSERVICO: String read FMNF_CODIGOPADRAOSERVICO write FMNF_CODIGOPADRAOSERVICO;
    const MNF_CODIGOPADRAOSERVICO_Name = 'MNF_CODIGOPADRAOSERVICO';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPODESCRICAOPRODUTO', ftString, 1)]
    [Dictionary('NFE_TIPODESCRICAOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPODESCRICAOPRODUTO: String read FNFE_TIPODESCRICAOPRODUTO write FNFE_TIPODESCRICAOPRODUTO;
    const NFE_TIPODESCRICAOPRODUTO_Name = 'NFE_TIPODESCRICAOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_MENSAGEMRODAPENOTASAIDA', ftString, 5000)]
    [Dictionary('NFE_MENSAGEMRODAPENOTASAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MENSAGEMRODAPENOTASAIDA: String read FNFE_MENSAGEMRODAPENOTASAIDA write FNFE_MENSAGEMRODAPENOTASAIDA;
    const NFE_MENSAGEMRODAPENOTASAIDA_Name = 'NFE_MENSAGEMRODAPENOTASAIDA';

    [Restrictions([NoValidate])]
    [Column('NFE_MENSAGEMRODAPENOTAENTRADA', ftString, 5000)]
    [Dictionary('NFE_MENSAGEMRODAPENOTAENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MENSAGEMRODAPENOTAENTRADA: String read FNFE_MENSAGEMRODAPENOTAENTRADA write FNFE_MENSAGEMRODAPENOTAENTRADA;
    const NFE_MENSAGEMRODAPENOTAENTRADA_Name = 'NFE_MENSAGEMRODAPENOTAENTRADA';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('NFE_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILSERVIDORENVIO: String read FNFE_EMAILSERVIDORENVIO write FNFE_EMAILSERVIDORENVIO;
    const NFE_EMAILSERVIDORENVIO_Name = 'NFE_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILENVIO', ftString, 100)]
    [Dictionary('NFE_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILENVIO: String read FNFE_EMAILENVIO write FNFE_EMAILENVIO;
    const NFE_EMAILENVIO_Name = 'NFE_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('NFE_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILUSUARIOENVIO: String read FNFE_EMAILUSUARIOENVIO write FNFE_EMAILUSUARIOENVIO;
    const NFE_EMAILUSUARIOENVIO_Name = 'NFE_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('NFE_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILSENHAENVIO: String read FNFE_EMAILSENHAENVIO write FNFE_EMAILSENHAENVIO;
    const NFE_EMAILSENHAENVIO_Name = 'NFE_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('NFE_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_EMAILPORTAENVIO: Integer read FNFE_EMAILPORTAENVIO write FNFE_EMAILPORTAENVIO;
    const NFE_EMAILPORTAENVIO_Name = 'NFE_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILSSL', ftString, 1)]
    [Dictionary('NFE_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILSSL: String read FNFE_EMAILSSL write FNFE_EMAILSSL;
    const NFE_EMAILSSL_Name = 'NFE_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILTLS', ftString, 1)]
    [Dictionary('NFE_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILTLS: String read FNFE_EMAILTLS write FNFE_EMAILTLS;
    const NFE_EMAILTLS_Name = 'NFE_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('NFE_ORDEMIMPRESSAOITENS', ftString, 1)]
    [Dictionary('NFE_ORDEMIMPRESSAOITENS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ORDEMIMPRESSAOITENS: String read FNFE_ORDEMIMPRESSAOITENS write FNFE_ORDEMIMPRESSAOITENS;
    const NFE_ORDEMIMPRESSAOITENS_Name = 'NFE_ORDEMIMPRESSAOITENS';

    [Restrictions([NoValidate])]
    [Column('NFE_CODIGOIDCSC', ftInteger)]
    [Dictionary('NFE_CODIGOIDCSC', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_CODIGOIDCSC: Integer read FNFE_CODIGOIDCSC write FNFE_CODIGOIDCSC;
    const NFE_CODIGOIDCSC_Name = 'NFE_CODIGOIDCSC';

    [Restrictions([NoValidate])]
    [Column('NFE_CODIGOCSC', ftString, 50)]
    [Dictionary('NFE_CODIGOCSC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CODIGOCSC: String read FNFE_CODIGOCSC write FNFE_CODIGOCSC;
    const NFE_CODIGOCSC_Name = 'NFE_CODIGOCSC';

    [Restrictions([NoValidate])]
    [Column('NFE_MOTIVOCONTIGENCIA', ftString, 5000)]
    [Dictionary('NFE_MOTIVOCONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MOTIVOCONTIGENCIA: String read FNFE_MOTIVOCONTIGENCIA write FNFE_MOTIVOCONTIGENCIA;
    const NFE_MOTIVOCONTIGENCIA_Name = 'NFE_MOTIVOCONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('NFE_IMPRIMENOTAPROMISSORIANFCE', ftString, 1)]
    [Dictionary('NFE_IMPRIMENOTAPROMISSORIANFCE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_IMPRIMENOTAPROMISSORIANFCE: String read FNFE_IMPRIMENOTAPROMISSORIANFCE write FNFE_IMPRIMENOTAPROMISSORIANFCE;
    const NFE_IMPRIMENOTAPROMISSORIANFCE_Name = 'NFE_IMPRIMENOTAPROMISSORIANFCE';

    [Restrictions([NoValidate])]
    [Column('NFSE_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('NFSE_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_AMBIENTEENVIO: String read FNFSE_AMBIENTEENVIO write FNFSE_AMBIENTEENVIO;
    const NFSE_AMBIENTEENVIO_Name = 'NFSE_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('NFSE_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_CERTIFICADONUMEROSERIE: String read FNFSE_CERTIFICADONUMEROSERIE write FNFSE_CERTIFICADONUMEROSERIE;
    const NFSE_CERTIFICADONUMEROSERIE_Name = 'NFSE_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('NFSE_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('NFSE_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_CERTIFICADOSENHA: String read FNFSE_CERTIFICADOSENHA write FNFSE_CERTIFICADOSENHA;
    const NFSE_CERTIFICADOSENHA_Name = 'NFSE_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('NFSE_SSLLIB', ftString, 1)]
    [Dictionary('NFSE_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_SSLLIB: String read FNFSE_SSLLIB write FNFSE_SSLLIB;
    const NFSE_SSLLIB_Name = 'NFSE_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('NFSE_IBGECIDADE', ftString, 7)]
    [Dictionary('NFSE_IBGECIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_IBGECIDADE: String read FNFSE_IBGECIDADE write FNFSE_IBGECIDADE;
    const NFSE_IBGECIDADE_Name = 'NFSE_IBGECIDADE';

    [Restrictions([NoValidate])]
    [Column('NFSE_NOMECIDADE', ftString, 100)]
    [Dictionary('NFSE_NOMECIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_NOMECIDADE: String read FNFSE_NOMECIDADE write FNFSE_NOMECIDADE;
    const NFSE_NOMECIDADE_Name = 'NFSE_NOMECIDADE';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYHOST', ftString, 50)]
    [Dictionary('NFSE_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PROXYHOST: String read FNFSE_PROXYHOST write FNFSE_PROXYHOST;
    const NFSE_PROXYHOST_Name = 'NFSE_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYPORTA', ftInteger)]
    [Dictionary('NFSE_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFSE_PROXYPORTA: Integer read FNFSE_PROXYPORTA write FNFSE_PROXYPORTA;
    const NFSE_PROXYPORTA_Name = 'NFSE_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYUSUARIO', ftString, 50)]
    [Dictionary('NFSE_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PROXYUSUARIO: String read FNFSE_PROXYUSUARIO write FNFSE_PROXYUSUARIO;
    const NFSE_PROXYUSUARIO_Name = 'NFSE_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYSENHA', ftString, 25)]
    [Dictionary('NFSE_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PROXYSENHA: String read FNFSE_PROXYSENHA write FNFSE_PROXYSENHA;
    const NFSE_PROXYSENHA_Name = 'NFSE_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('NFSE_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHLOGOMARCA: String read FNFSE_PATHLOGOMARCA write FNFSE_PATHLOGOMARCA;
    const NFSE_PATHLOGOMARCA_Name = 'NFSE_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHLOGOMARCAPREFEITURA', ftString, 255)]
    [Dictionary('NFSE_PATHLOGOMARCAPREFEITURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHLOGOMARCAPREFEITURA: String read FNFSE_PATHLOGOMARCAPREFEITURA write FNFSE_PATHLOGOMARCAPREFEITURA;
    const NFSE_PATHLOGOMARCAPREFEITURA_Name = 'NFSE_PATHLOGOMARCAPREFEITURA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHSCHEMAPROVEDOR', ftString, 255)]
    [Dictionary('NFSE_PATHSCHEMAPROVEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHSCHEMAPROVEDOR: String read FNFSE_PATHSCHEMAPROVEDOR write FNFSE_PATHSCHEMAPROVEDOR;
    const NFSE_PATHSCHEMAPROVEDOR_Name = 'NFSE_PATHSCHEMAPROVEDOR';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('NFSE_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHREPOSITORIO: String read FNFSE_PATHREPOSITORIO write FNFSE_PATHREPOSITORIO;
    const NFSE_PATHREPOSITORIO_Name = 'NFSE_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHARQUIVOINI', ftString, 255)]
    [Dictionary('NFSE_PATHARQUIVOINI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHARQUIVOINI: String read FNFSE_PATHARQUIVOINI write FNFSE_PATHARQUIVOINI;
    const NFSE_PATHARQUIVOINI_Name = 'NFSE_PATHARQUIVOINI';

    [Restrictions([NoValidate])]
    [Column('NFSE_ATUALIZARNOTASINICIAR', ftString, 1)]
    [Dictionary('NFSE_ATUALIZARNOTASINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_ATUALIZARNOTASINICIAR: String read FNFSE_ATUALIZARNOTASINICIAR write FNFSE_ATUALIZARNOTASINICIAR;
    const NFSE_ATUALIZARNOTASINICIAR_Name = 'NFSE_ATUALIZARNOTASINICIAR';

    [Restrictions([NoValidate])]
    [Column('NFSE_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('NFSE_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_ENVIAREMAILAPOSAUTORIZACAO: String read FNFSE_ENVIAREMAILAPOSAUTORIZACAO write FNFSE_ENVIAREMAILAPOSAUTORIZACAO;
    const NFSE_ENVIAREMAILAPOSAUTORIZACAO_Name = 'NFSE_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('NFSE_WEBUSUARIO', ftString, 50)]
    [Dictionary('NFSE_WEBUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_WEBUSUARIO: String read FNFSE_WEBUSUARIO write FNFSE_WEBUSUARIO;
    const NFSE_WEBUSUARIO_Name = 'NFSE_WEBUSUARIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_WEBSENHA', ftString, 25)]
    [Dictionary('NFSE_WEBSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_WEBSENHA: String read FNFSE_WEBSENHA write FNFSE_WEBSENHA;
    const NFSE_WEBSENHA_Name = 'NFSE_WEBSENHA';

    [Restrictions([NoValidate])]
    [Column('NFSE_WEBFRASESECRETA', ftString, 50)]
    [Dictionary('NFSE_WEBFRASESECRETA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_WEBFRASESECRETA: String read FNFSE_WEBFRASESECRETA write FNFSE_WEBFRASESECRETA;
    const NFSE_WEBFRASESECRETA_Name = 'NFSE_WEBFRASESECRETA';

    [Restrictions([NoValidate])]
    [Column('NFSE_REGIMETRIBUTACAO', ftInteger)]
    [Dictionary('NFSE_REGIMETRIBUTACAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFSE_REGIMETRIBUTACAO: Integer read FNFSE_REGIMETRIBUTACAO write FNFSE_REGIMETRIBUTACAO;
    const NFSE_REGIMETRIBUTACAO_Name = 'NFSE_REGIMETRIBUTACAO';

    [Restrictions([NoValidate])]
    [Column('NFSE_INCENTIVADORCULTURAL', ftString, 1)]
    [Dictionary('NFSE_INCENTIVADORCULTURAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_INCENTIVADORCULTURAL: String read FNFSE_INCENTIVADORCULTURAL write FNFSE_INCENTIVADORCULTURAL;
    const NFSE_INCENTIVADORCULTURAL_Name = 'NFSE_INCENTIVADORCULTURAL';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('NFSE_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHARQENVIORESPOSTA: String read FNFSE_PATHARQENVIORESPOSTA write FNFSE_PATHARQENVIORESPOSTA;
    const NFSE_PATHARQENVIORESPOSTA_Name = 'NFSE_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('NFSE_VALORMINRETENCAOFEDERAL', ftBCD)]
    [Dictionary('NFSE_VALORMINRETENCAOFEDERAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFSE_VALORMINRETENCAOFEDERAL: Double read FNFSE_VALORMINRETENCAOFEDERAL write FNFSE_VALORMINRETENCAOFEDERAL;
    const NFSE_VALORMINRETENCAOFEDERAL_Name = 'NFSE_VALORMINRETENCAOFEDERAL';

    [Restrictions([NoValidate])]
    [Column('NFSE_VALORMINRETENCAOIR', ftBCD, 3145777, 2)]
    [Dictionary('NFSE_VALORMINRETENCAOIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFSE_VALORMINRETENCAOIR: Double read FNFSE_VALORMINRETENCAOIR write FNFSE_VALORMINRETENCAOIR;
    const NFSE_VALORMINRETENCAOIR_Name = 'NFSE_VALORMINRETENCAOIR';

    [Restrictions([NoValidate])]
    [Column('NFE_CNPJSEFAZUFEMITENTE', ftString, 14)]
    [Dictionary('NFE_CNPJSEFAZUFEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CNPJSEFAZUFEMITENTE: String read FNFE_CNPJSEFAZUFEMITENTE write FNFE_CNPJSEFAZUFEMITENTE;
    const NFE_CNPJSEFAZUFEMITENTE_Name = 'NFE_CNPJSEFAZUFEMITENTE';

    [Restrictions([NoValidate])]
    [Column('NFE_DADOSCERTIFICADO_A1PFX', ftBlob)]
    [Dictionary('NFE_DADOSCERTIFICADO_A1PFX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_DADOSCERTIFICADO_A1PFX: TBlob read FNFE_DADOSCERTIFICADO_A1PFX write FNFE_DADOSCERTIFICADO_A1PFX;
    const NFE_DADOSCERTIFICADO_A1PFX_Name = 'NFE_DADOSCERTIFICADO_A1PFX';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_ATIV', ftString, 1)]
    [Dictionary('CFG_IND_ATIV', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_ATIV: String read FCFG_IND_ATIV write FCFG_IND_ATIV;
    const CFG_IND_ATIV_Name = 'CFG_IND_ATIV';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPO_ESCRIT', ftString, 1)]
    [Dictionary('CFG_TIPO_ESCRIT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPO_ESCRIT: String read FCFG_TIPO_ESCRIT write FCFG_TIPO_ESCRIT;
    const CFG_TIPO_ESCRIT_Name = 'CFG_TIPO_ESCRIT';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_NAT_PJ', ftString, 2)]
    [Dictionary('CFG_IND_NAT_PJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_NAT_PJ: String read FCFG_IND_NAT_PJ write FCFG_IND_NAT_PJ;
    const CFG_IND_NAT_PJ_Name = 'CFG_IND_NAT_PJ';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_INC_TRIB', ftString, 1)]
    [Dictionary('CFG_COD_INC_TRIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_INC_TRIB: String read FCFG_COD_INC_TRIB write FCFG_COD_INC_TRIB;
    const CFG_COD_INC_TRIB_Name = 'CFG_COD_INC_TRIB';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_APRO_CRED', ftString, 1)]
    [Dictionary('CFG_IND_APRO_CRED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_APRO_CRED: String read FCFG_IND_APRO_CRED write FCFG_IND_APRO_CRED;
    const CFG_IND_APRO_CRED_Name = 'CFG_IND_APRO_CRED';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_REG_CUM', ftString, 1)]
    [Dictionary('CFG_IND_REG_CUM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_REG_CUM: String read FCFG_IND_REG_CUM write FCFG_IND_REG_CUM;
    const CFG_IND_REG_CUM_Name = 'CFG_IND_REG_CUM';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_ESCRI', ftString, 1)]
    [Dictionary('CFG_IND_ESCRI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_ESCRI: String read FCFG_IND_ESCRI write FCFG_IND_ESCRI;
    const CFG_IND_ESCRI_Name = 'CFG_IND_ESCRI';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_SIT_ESP', ftString, 1)]
    [Dictionary('CFG_IND_SIT_ESP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_SIT_ESP: String read FCFG_IND_SIT_ESP write FCFG_IND_SIT_ESP;
    const CFG_IND_SIT_ESP_Name = 'CFG_IND_SIT_ESP';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_TIPO_CONT', ftString, 1)]
    [Dictionary('CFG_COD_TIPO_CONT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_TIPO_CONT: String read FCFG_COD_TIPO_CONT write FCFG_COD_TIPO_CONT;
    const CFG_COD_TIPO_CONT_Name = 'CFG_COD_TIPO_CONT';

    [Restrictions([NoValidate])]
    [Column('CFG_GERASPED', ftString, 1)]
    [Dictionary('CFG_GERASPED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_GERASPED: String read FCFG_GERASPED write FCFG_GERASPED;
    const CFG_GERASPED_Name = 'CFG_GERASPED';

    [Restrictions([NoValidate])]
    [Column('CFG_ACPREVIDENCIARIARECEITAB', ftString, 1)]
    [Dictionary('CFG_ACPREVIDENCIARIARECEITAB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_ACPREVIDENCIARIARECEITAB: String read FCFG_ACPREVIDENCIARIARECEITAB write FCFG_ACPREVIDENCIARIARECEITAB;
    const CFG_ACPREVIDENCIARIARECEITAB_Name = 'CFG_ACPREVIDENCIARIARECEITAB';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_VER_FISCAL', ftString, 3)]
    [Dictionary('CFG_COD_VER_FISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_VER_FISCAL: String read FCFG_COD_VER_FISCAL write FCFG_COD_VER_FISCAL;
    const CFG_COD_VER_FISCAL_Name = 'CFG_COD_VER_FISCAL';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_FISCAL', ftString, 6)]
    [Dictionary('CFG_COD_REC_FISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_FISCAL: String read FCFG_COD_REC_FISCAL write FCFG_COD_REC_FISCAL;
    const CFG_COD_REC_FISCAL_Name = 'CFG_COD_REC_FISCAL';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_VER_SPEDPC', ftString, 3)]
    [Dictionary('CFG_COD_VER_SPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_VER_SPEDPC: String read FCFG_COD_VER_SPEDPC write FCFG_COD_VER_SPEDPC;
    const CFG_COD_VER_SPEDPC_Name = 'CFG_COD_VER_SPEDPC';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_SPEDPC', ftString, 6)]
    [Dictionary('CFG_COD_REC_SPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_SPEDPC: String read FCFG_COD_REC_SPEDPC write FCFG_COD_REC_SPEDPC;
    const CFG_COD_REC_SPEDPC_Name = 'CFG_COD_REC_SPEDPC';

    [Restrictions([NoValidate])]
    [Column('CFG_NUM_CAMPO', ftString, 2)]
    [Dictionary('CFG_NUM_CAMPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_NUM_CAMPO: String read FCFG_NUM_CAMPO write FCFG_NUM_CAMPO;
    const CFG_NUM_CAMPO_Name = 'CFG_NUM_CAMPO';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_M205', ftString, 6)]
    [Dictionary('CFG_COD_REC_M205', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_M205: String read FCFG_COD_REC_M205 write FCFG_COD_REC_M205;
    const CFG_COD_REC_M205_Name = 'CFG_COD_REC_M205';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_M605', ftString, 6)]
    [Dictionary('CFG_COD_REC_M605', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_M605: String read FCFG_COD_REC_M605 write FCFG_COD_REC_M605;
    const CFG_COD_REC_M605_Name = 'CFG_COD_REC_M605';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_1400_PRODUTOR', ftString, 60)]
    [Dictionary('CFG_COD_1400_PRODUTOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_1400_PRODUTOR: String read FCFG_COD_1400_PRODUTOR write FCFG_COD_1400_PRODUTOR;
    const CFG_COD_1400_PRODUTOR_Name = 'CFG_COD_1400_PRODUTOR';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_1400_VEICULO', ftString, 60)]
    [Dictionary('CFG_COD_1400_VEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_1400_VEICULO: String read FCFG_COD_1400_VEICULO write FCFG_COD_1400_VEICULO;
    const CFG_COD_1400_VEICULO_Name = 'CFG_COD_1400_VEICULO';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_1400_TRANSPORTE', ftString, 60)]
    [Dictionary('CFG_COD_1400_TRANSPORTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_1400_TRANSPORTE: String read FCFG_COD_1400_TRANSPORTE write FCFG_COD_1400_TRANSPORTE;
    const CFG_COD_1400_TRANSPORTE_Name = 'CFG_COD_1400_TRANSPORTE';

    [Restrictions([NoValidate])]
    [Column('CFG_CONFIGURACOES_SPED', ftString, 100)]
    [Dictionary('CFG_CONFIGURACOES_SPED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CONFIGURACOES_SPED: String read FCFG_CONFIGURACOES_SPED write FCFG_CONFIGURACOES_SPED;
    const CFG_CONFIGURACOES_SPED_Name = 'CFG_CONFIGURACOES_SPED';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOJUROSCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOJUROSCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOJUROSCRE: Integer read FPLC_CODIGOPADRAOJUROSCRE write FPLC_CODIGOPADRAOJUROSCRE;
    const PLC_CODIGOPADRAOJUROSCRE_Name = 'PLC_CODIGOPADRAOJUROSCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOMULTACRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOMULTACRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOMULTACRE: Integer read FPLC_CODIGOPADRAOMULTACRE write FPLC_CODIGOPADRAOMULTACRE;
    const PLC_CODIGOPADRAOMULTACRE_Name = 'PLC_CODIGOPADRAOMULTACRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESPESASCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESPESASCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESPESASCRE: Integer read FPLC_CODIGOPADRAODESPESASCRE write FPLC_CODIGOPADRAODESPESASCRE;
    const PLC_CODIGOPADRAODESPESASCRE_Name = 'PLC_CODIGOPADRAODESPESASCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOCARTORIOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOCARTORIOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOCARTORIOCRE: Integer read FPLC_CODIGOPADRAOCARTORIOCRE write FPLC_CODIGOPADRAOCARTORIOCRE;
    const PLC_CODIGOPADRAOCARTORIOCRE_Name = 'PLC_CODIGOPADRAOCARTORIOCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESCONTOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESCONTOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESCONTOCRE: Integer read FPLC_CODIGOPADRAODESCONTOCRE write FPLC_CODIGOPADRAODESCONTOCRE;
    const PLC_CODIGOPADRAODESCONTOCRE_Name = 'PLC_CODIGOPADRAODESCONTOCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESPCARTAOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESPCARTAOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESPCARTAOCRE: Integer read FPLC_CODIGOPADRAODESPCARTAOCRE write FPLC_CODIGOPADRAODESPCARTAOCRE;
    const PLC_CODIGOPADRAODESPCARTAOCRE_Name = 'PLC_CODIGOPADRAODESPCARTAOCRE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOFINANCEIROCRE', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOFINANCEIROCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOFINANCEIROCRE: Integer read FCCU_CODIGOPADRAOFINANCEIROCRE write FCCU_CODIGOPADRAOFINANCEIROCRE;
    const CCU_CODIGOPADRAOFINANCEIROCRE_Name = 'CCU_CODIGOPADRAOFINANCEIROCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOJUROSCPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOJUROSCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOJUROSCPA: Integer read FPLC_CODIGOPADRAOJUROSCPA write FPLC_CODIGOPADRAOJUROSCPA;
    const PLC_CODIGOPADRAOJUROSCPA_Name = 'PLC_CODIGOPADRAOJUROSCPA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOMULTACPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOMULTACPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOMULTACPA: Integer read FPLC_CODIGOPADRAOMULTACPA write FPLC_CODIGOPADRAOMULTACPA;
    const PLC_CODIGOPADRAOMULTACPA_Name = 'PLC_CODIGOPADRAOMULTACPA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESCONTOCPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESCONTOCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESCONTOCPA: Integer read FPLC_CODIGOPADRAODESCONTOCPA write FPLC_CODIGOPADRAODESCONTOCPA;
    const PLC_CODIGOPADRAODESCONTOCPA_Name = 'PLC_CODIGOPADRAODESCONTOCPA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESPESASCPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESPESASCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESPESASCPA: Integer read FPLC_CODIGOPADRAODESPESASCPA write FPLC_CODIGOPADRAODESPESASCPA;
    const PLC_CODIGOPADRAODESPESASCPA_Name = 'PLC_CODIGOPADRAODESPESASCPA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOFINANCEIROCPA', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOFINANCEIROCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOFINANCEIROCPA: Integer read FCCU_CODIGOPADRAOFINANCEIROCPA write FCCU_CODIGOPADRAOFINANCEIROCPA;
    const CCU_CODIGOPADRAOFINANCEIROCPA_Name = 'CCU_CODIGOPADRAOFINANCEIROCPA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOPRODUCAO', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOPRODUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOPRODUCAO: Integer read FCCU_CODIGOPADRAOPRODUCAO write FCCU_CODIGOPADRAOPRODUCAO;
    const CCU_CODIGOPADRAOPRODUCAO_Name = 'CCU_CODIGOPADRAOPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOPRODUCAO', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOPRODUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOPRODUCAO: Integer read FPLC_CODIGOPADRAOPRODUCAO write FPLC_CODIGOPADRAOPRODUCAO;
    const PLC_CODIGOPADRAOPRODUCAO_Name = 'PLC_CODIGOPADRAOPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOTRANSFERENCIA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOTRANSFERENCIA: Integer read FPLC_CODIGOPADRAOTRANSFERENCIA write FPLC_CODIGOPADRAOTRANSFERENCIA;
    const PLC_CODIGOPADRAOTRANSFERENCIA_Name = 'PLC_CODIGOPADRAOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOTRANSFERENCIA', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOTRANSFERENCIA: Integer read FCCU_CODIGOPADRAOTRANSFERENCIA write FCCU_CODIGOPADRAOTRANSFERENCIA;
    const CCU_CODIGOPADRAOTRANSFERENCIA_Name = 'CCU_CODIGOPADRAOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOTARIFABOLETOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOTARIFABOLETOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOTARIFABOLETOCRE: Integer read FPLC_CODIGOPADRAOTARIFABOLETOCRE write FPLC_CODIGOPADRAOTARIFABOLETOCRE;
    const PLC_CODIGOPADRAOTARIFABOLETOCRE_Name = 'PLC_CODIGOPADRAOTARIFABOLETOCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOBCX', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOBCX', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOBCX: Integer read FPLC_CODIGOPADRAOBCX write FPLC_CODIGOPADRAOBCX;
    const PLC_CODIGOPADRAOBCX_Name = 'PLC_CODIGOPADRAOBCX';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOBCX', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOBCX', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOBCX: Integer read FCCU_CODIGOPADRAOBCX write FCCU_CODIGOPADRAOBCX;
    const CCU_CODIGOPADRAOBCX_Name = 'CCU_CODIGOPADRAOBCX';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAONFE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAONFE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAONFE: Integer read FPLC_CODIGOPADRAONFE write FPLC_CODIGOPADRAONFE;
    const PLC_CODIGOPADRAONFE_Name = 'PLC_CODIGOPADRAONFE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAONFE', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAONFE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAONFE: Integer read FCCU_CODIGOPADRAONFE write FCCU_CODIGOPADRAONFE;
    const CCU_CODIGOPADRAONFE_Name = 'CCU_CODIGOPADRAONFE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOSEE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOSEE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOSEE: Integer read FPLC_CODIGOPADRAOSEE write FPLC_CODIGOPADRAOSEE;
    const PLC_CODIGOPADRAOSEE_Name = 'PLC_CODIGOPADRAOSEE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOSEE', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOSEE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOSEE: Integer read FCCU_CODIGOPADRAOSEE write FCCU_CODIGOPADRAOSEE;
    const CCU_CODIGOPADRAOSEE_Name = 'CCU_CODIGOPADRAOSEE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOUNICO', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOUNICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOUNICO: Integer read FCCU_CODIGOPADRAOUNICO write FCCU_CODIGOPADRAOUNICO;
    const CCU_CODIGOPADRAOUNICO_Name = 'CCU_CODIGOPADRAOUNICO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOANTECIPACAOFOR', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOANTECIPACAOFOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOANTECIPACAOFOR: Integer read FPLC_CODIGOPADRAOANTECIPACAOFOR write FPLC_CODIGOPADRAOANTECIPACAOFOR;
    const PLC_CODIGOPADRAOANTECIPACAOFOR_Name = 'PLC_CODIGOPADRAOANTECIPACAOFOR';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOANTECIPACAOFOR', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOANTECIPACAOFOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOANTECIPACAOFOR: Integer read FCCU_CODIGOPADRAOANTECIPACAOFOR write FCCU_CODIGOPADRAOANTECIPACAOFOR;
    const CCU_CODIGOPADRAOANTECIPACAOFOR_Name = 'CCU_CODIGOPADRAOANTECIPACAOFOR';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOANTECIPACAOCLI', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOANTECIPACAOCLI', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOANTECIPACAOCLI: Integer read FPLC_CODIGOPADRAOANTECIPACAOCLI write FPLC_CODIGOPADRAOANTECIPACAOCLI;
    const PLC_CODIGOPADRAOANTECIPACAOCLI_Name = 'PLC_CODIGOPADRAOANTECIPACAOCLI';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOANTECIPACAOCLI', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOANTECIPACAOCLI', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOANTECIPACAOCLI: Integer read FCCU_CODIGOPADRAOANTECIPACAOCLI write FCCU_CODIGOPADRAOANTECIPACAOCLI;
    const CCU_CODIGOPADRAOANTECIPACAOCLI_Name = 'CCU_CODIGOPADRAOANTECIPACAOCLI';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_00', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_00', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_00: String read FCFG_TRIBUTACAOENTRADACST_00 write FCFG_TRIBUTACAOENTRADACST_00;
    const CFG_TRIBUTACAOENTRADACST_00_Name = 'CFG_TRIBUTACAOENTRADACST_00';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_10', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_10', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_10: String read FCFG_TRIBUTACAOENTRADACST_10 write FCFG_TRIBUTACAOENTRADACST_10;
    const CFG_TRIBUTACAOENTRADACST_10_Name = 'CFG_TRIBUTACAOENTRADACST_10';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_20', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_20', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_20: String read FCFG_TRIBUTACAOENTRADACST_20 write FCFG_TRIBUTACAOENTRADACST_20;
    const CFG_TRIBUTACAOENTRADACST_20_Name = 'CFG_TRIBUTACAOENTRADACST_20';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_30', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_30', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_30: String read FCFG_TRIBUTACAOENTRADACST_30 write FCFG_TRIBUTACAOENTRADACST_30;
    const CFG_TRIBUTACAOENTRADACST_30_Name = 'CFG_TRIBUTACAOENTRADACST_30';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_40', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_40', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_40: String read FCFG_TRIBUTACAOENTRADACST_40 write FCFG_TRIBUTACAOENTRADACST_40;
    const CFG_TRIBUTACAOENTRADACST_40_Name = 'CFG_TRIBUTACAOENTRADACST_40';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_41', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_41', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_41: String read FCFG_TRIBUTACAOENTRADACST_41 write FCFG_TRIBUTACAOENTRADACST_41;
    const CFG_TRIBUTACAOENTRADACST_41_Name = 'CFG_TRIBUTACAOENTRADACST_41';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_50', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_50', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_50: String read FCFG_TRIBUTACAOENTRADACST_50 write FCFG_TRIBUTACAOENTRADACST_50;
    const CFG_TRIBUTACAOENTRADACST_50_Name = 'CFG_TRIBUTACAOENTRADACST_50';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_51', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_51', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_51: String read FCFG_TRIBUTACAOENTRADACST_51 write FCFG_TRIBUTACAOENTRADACST_51;
    const CFG_TRIBUTACAOENTRADACST_51_Name = 'CFG_TRIBUTACAOENTRADACST_51';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_60', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_60', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_60: String read FCFG_TRIBUTACAOENTRADACST_60 write FCFG_TRIBUTACAOENTRADACST_60;
    const CFG_TRIBUTACAOENTRADACST_60_Name = 'CFG_TRIBUTACAOENTRADACST_60';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_70', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_70', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_70: String read FCFG_TRIBUTACAOENTRADACST_70 write FCFG_TRIBUTACAOENTRADACST_70;
    const CFG_TRIBUTACAOENTRADACST_70_Name = 'CFG_TRIBUTACAOENTRADACST_70';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOENTRADACST_90', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOENTRADACST_90', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOENTRADACST_90: String read FCFG_TRIBUTACAOENTRADACST_90 write FCFG_TRIBUTACAOENTRADACST_90;
    const CFG_TRIBUTACAOENTRADACST_90_Name = 'CFG_TRIBUTACAOENTRADACST_90';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_00', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_00', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_00: String read FCFG_TRIBUTACAOSAIDACST_00 write FCFG_TRIBUTACAOSAIDACST_00;
    const CFG_TRIBUTACAOSAIDACST_00_Name = 'CFG_TRIBUTACAOSAIDACST_00';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_10', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_10', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_10: String read FCFG_TRIBUTACAOSAIDACST_10 write FCFG_TRIBUTACAOSAIDACST_10;
    const CFG_TRIBUTACAOSAIDACST_10_Name = 'CFG_TRIBUTACAOSAIDACST_10';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_20', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_20', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_20: String read FCFG_TRIBUTACAOSAIDACST_20 write FCFG_TRIBUTACAOSAIDACST_20;
    const CFG_TRIBUTACAOSAIDACST_20_Name = 'CFG_TRIBUTACAOSAIDACST_20';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_30', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_30', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_30: String read FCFG_TRIBUTACAOSAIDACST_30 write FCFG_TRIBUTACAOSAIDACST_30;
    const CFG_TRIBUTACAOSAIDACST_30_Name = 'CFG_TRIBUTACAOSAIDACST_30';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_40', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_40', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_40: String read FCFG_TRIBUTACAOSAIDACST_40 write FCFG_TRIBUTACAOSAIDACST_40;
    const CFG_TRIBUTACAOSAIDACST_40_Name = 'CFG_TRIBUTACAOSAIDACST_40';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_41', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_41', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_41: String read FCFG_TRIBUTACAOSAIDACST_41 write FCFG_TRIBUTACAOSAIDACST_41;
    const CFG_TRIBUTACAOSAIDACST_41_Name = 'CFG_TRIBUTACAOSAIDACST_41';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_50', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_50', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_50: String read FCFG_TRIBUTACAOSAIDACST_50 write FCFG_TRIBUTACAOSAIDACST_50;
    const CFG_TRIBUTACAOSAIDACST_50_Name = 'CFG_TRIBUTACAOSAIDACST_50';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_51', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_51', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_51: String read FCFG_TRIBUTACAOSAIDACST_51 write FCFG_TRIBUTACAOSAIDACST_51;
    const CFG_TRIBUTACAOSAIDACST_51_Name = 'CFG_TRIBUTACAOSAIDACST_51';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_60', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_60', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_60: String read FCFG_TRIBUTACAOSAIDACST_60 write FCFG_TRIBUTACAOSAIDACST_60;
    const CFG_TRIBUTACAOSAIDACST_60_Name = 'CFG_TRIBUTACAOSAIDACST_60';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_70', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_70', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_70: String read FCFG_TRIBUTACAOSAIDACST_70 write FCFG_TRIBUTACAOSAIDACST_70;
    const CFG_TRIBUTACAOSAIDACST_70_Name = 'CFG_TRIBUTACAOSAIDACST_70';

    [Restrictions([NoValidate])]
    [Column('CFG_TRIBUTACAOSAIDACST_90', ftString, 1)]
    [Dictionary('CFG_TRIBUTACAOSAIDACST_90', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TRIBUTACAOSAIDACST_90: String read FCFG_TRIBUTACAOSAIDACST_90 write FCFG_TRIBUTACAOSAIDACST_90;
    const CFG_TRIBUTACAOSAIDACST_90_Name = 'CFG_TRIBUTACAOSAIDACST_90';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_00', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_00', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_00: String read FCST_CODIGOPADRAOENTRADACST_00 write FCST_CODIGOPADRAOENTRADACST_00;
    const CST_CODIGOPADRAOENTRADACST_00_Name = 'CST_CODIGOPADRAOENTRADACST_00';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_10', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_10', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_10: String read FCST_CODIGOPADRAOENTRADACST_10 write FCST_CODIGOPADRAOENTRADACST_10;
    const CST_CODIGOPADRAOENTRADACST_10_Name = 'CST_CODIGOPADRAOENTRADACST_10';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_20', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_20', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_20: String read FCST_CODIGOPADRAOENTRADACST_20 write FCST_CODIGOPADRAOENTRADACST_20;
    const CST_CODIGOPADRAOENTRADACST_20_Name = 'CST_CODIGOPADRAOENTRADACST_20';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_30', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_30', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_30: String read FCST_CODIGOPADRAOENTRADACST_30 write FCST_CODIGOPADRAOENTRADACST_30;
    const CST_CODIGOPADRAOENTRADACST_30_Name = 'CST_CODIGOPADRAOENTRADACST_30';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_40', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_40', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_40: String read FCST_CODIGOPADRAOENTRADACST_40 write FCST_CODIGOPADRAOENTRADACST_40;
    const CST_CODIGOPADRAOENTRADACST_40_Name = 'CST_CODIGOPADRAOENTRADACST_40';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_41', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_41', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_41: String read FCST_CODIGOPADRAOENTRADACST_41 write FCST_CODIGOPADRAOENTRADACST_41;
    const CST_CODIGOPADRAOENTRADACST_41_Name = 'CST_CODIGOPADRAOENTRADACST_41';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_50', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_50', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_50: String read FCST_CODIGOPADRAOENTRADACST_50 write FCST_CODIGOPADRAOENTRADACST_50;
    const CST_CODIGOPADRAOENTRADACST_50_Name = 'CST_CODIGOPADRAOENTRADACST_50';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_51', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_51', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_51: String read FCST_CODIGOPADRAOENTRADACST_51 write FCST_CODIGOPADRAOENTRADACST_51;
    const CST_CODIGOPADRAOENTRADACST_51_Name = 'CST_CODIGOPADRAOENTRADACST_51';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_60', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_60', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_60: String read FCST_CODIGOPADRAOENTRADACST_60 write FCST_CODIGOPADRAOENTRADACST_60;
    const CST_CODIGOPADRAOENTRADACST_60_Name = 'CST_CODIGOPADRAOENTRADACST_60';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_70', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_70', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_70: String read FCST_CODIGOPADRAOENTRADACST_70 write FCST_CODIGOPADRAOENTRADACST_70;
    const CST_CODIGOPADRAOENTRADACST_70_Name = 'CST_CODIGOPADRAOENTRADACST_70';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAOENTRADACST_90', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAOENTRADACST_90', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAOENTRADACST_90: String read FCST_CODIGOPADRAOENTRADACST_90 write FCST_CODIGOPADRAOENTRADACST_90;
    const CST_CODIGOPADRAOENTRADACST_90_Name = 'CST_CODIGOPADRAOENTRADACST_90';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_00', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_00', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_00: String read FCFOP_CODIGOPADRAOENTRADACST_00 write FCFOP_CODIGOPADRAOENTRADACST_00;
    const CFOP_CODIGOPADRAOENTRADACST_00_Name = 'CFOP_CODIGOPADRAOENTRADACST_00';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_10', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_10', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_10: String read FCFOP_CODIGOPADRAOENTRADACST_10 write FCFOP_CODIGOPADRAOENTRADACST_10;
    const CFOP_CODIGOPADRAOENTRADACST_10_Name = 'CFOP_CODIGOPADRAOENTRADACST_10';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_20', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_20', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_20: String read FCFOP_CODIGOPADRAOENTRADACST_20 write FCFOP_CODIGOPADRAOENTRADACST_20;
    const CFOP_CODIGOPADRAOENTRADACST_20_Name = 'CFOP_CODIGOPADRAOENTRADACST_20';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_30', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_30', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_30: String read FCFOP_CODIGOPADRAOENTRADACST_30 write FCFOP_CODIGOPADRAOENTRADACST_30;
    const CFOP_CODIGOPADRAOENTRADACST_30_Name = 'CFOP_CODIGOPADRAOENTRADACST_30';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_40', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_40', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_40: String read FCFOP_CODIGOPADRAOENTRADACST_40 write FCFOP_CODIGOPADRAOENTRADACST_40;
    const CFOP_CODIGOPADRAOENTRADACST_40_Name = 'CFOP_CODIGOPADRAOENTRADACST_40';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_41', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_41', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_41: String read FCFOP_CODIGOPADRAOENTRADACST_41 write FCFOP_CODIGOPADRAOENTRADACST_41;
    const CFOP_CODIGOPADRAOENTRADACST_41_Name = 'CFOP_CODIGOPADRAOENTRADACST_41';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_50', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_50', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_50: String read FCFOP_CODIGOPADRAOENTRADACST_50 write FCFOP_CODIGOPADRAOENTRADACST_50;
    const CFOP_CODIGOPADRAOENTRADACST_50_Name = 'CFOP_CODIGOPADRAOENTRADACST_50';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_51', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_51', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_51: String read FCFOP_CODIGOPADRAOENTRADACST_51 write FCFOP_CODIGOPADRAOENTRADACST_51;
    const CFOP_CODIGOPADRAOENTRADACST_51_Name = 'CFOP_CODIGOPADRAOENTRADACST_51';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_60', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_60', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_60: String read FCFOP_CODIGOPADRAOENTRADACST_60 write FCFOP_CODIGOPADRAOENTRADACST_60;
    const CFOP_CODIGOPADRAOENTRADACST_60_Name = 'CFOP_CODIGOPADRAOENTRADACST_60';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_70', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_70', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_70: String read FCFOP_CODIGOPADRAOENTRADACST_70 write FCFOP_CODIGOPADRAOENTRADACST_70;
    const CFOP_CODIGOPADRAOENTRADACST_70_Name = 'CFOP_CODIGOPADRAOENTRADACST_70';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOPADRAOENTRADACST_90', ftString, 4)]
    [Dictionary('CFOP_CODIGOPADRAOENTRADACST_90', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOPADRAOENTRADACST_90: String read FCFOP_CODIGOPADRAOENTRADACST_90 write FCFOP_CODIGOPADRAOENTRADACST_90;
    const CFOP_CODIGOPADRAOENTRADACST_90_Name = 'CFOP_CODIGOPADRAOENTRADACST_90';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_00', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_00', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_00: Integer read FNCM_CODIGOPADRAOENTRADACST_00 write FNCM_CODIGOPADRAOENTRADACST_00;
    const NCM_CODIGOPADRAOENTRADACST_00_Name = 'NCM_CODIGOPADRAOENTRADACST_00';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_10', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_10', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_10: Integer read FNCM_CODIGOPADRAOENTRADACST_10 write FNCM_CODIGOPADRAOENTRADACST_10;
    const NCM_CODIGOPADRAOENTRADACST_10_Name = 'NCM_CODIGOPADRAOENTRADACST_10';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_20', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_20', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_20: Integer read FNCM_CODIGOPADRAOENTRADACST_20 write FNCM_CODIGOPADRAOENTRADACST_20;
    const NCM_CODIGOPADRAOENTRADACST_20_Name = 'NCM_CODIGOPADRAOENTRADACST_20';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_30', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_30', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_30: Integer read FNCM_CODIGOPADRAOENTRADACST_30 write FNCM_CODIGOPADRAOENTRADACST_30;
    const NCM_CODIGOPADRAOENTRADACST_30_Name = 'NCM_CODIGOPADRAOENTRADACST_30';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_40', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_40', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_40: Integer read FNCM_CODIGOPADRAOENTRADACST_40 write FNCM_CODIGOPADRAOENTRADACST_40;
    const NCM_CODIGOPADRAOENTRADACST_40_Name = 'NCM_CODIGOPADRAOENTRADACST_40';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_41', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_41', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_41: Integer read FNCM_CODIGOPADRAOENTRADACST_41 write FNCM_CODIGOPADRAOENTRADACST_41;
    const NCM_CODIGOPADRAOENTRADACST_41_Name = 'NCM_CODIGOPADRAOENTRADACST_41';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_50', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_50', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_50: Integer read FNCM_CODIGOPADRAOENTRADACST_50 write FNCM_CODIGOPADRAOENTRADACST_50;
    const NCM_CODIGOPADRAOENTRADACST_50_Name = 'NCM_CODIGOPADRAOENTRADACST_50';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_51', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_51', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_51: Integer read FNCM_CODIGOPADRAOENTRADACST_51 write FNCM_CODIGOPADRAOENTRADACST_51;
    const NCM_CODIGOPADRAOENTRADACST_51_Name = 'NCM_CODIGOPADRAOENTRADACST_51';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_60', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_60', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_60: Integer read FNCM_CODIGOPADRAOENTRADACST_60 write FNCM_CODIGOPADRAOENTRADACST_60;
    const NCM_CODIGOPADRAOENTRADACST_60_Name = 'NCM_CODIGOPADRAOENTRADACST_60';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_70', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_70', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_70: Integer read FNCM_CODIGOPADRAOENTRADACST_70 write FNCM_CODIGOPADRAOENTRADACST_70;
    const NCM_CODIGOPADRAOENTRADACST_70_Name = 'NCM_CODIGOPADRAOENTRADACST_70';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGOPADRAOENTRADACST_90', ftInteger)]
    [Dictionary('NCM_CODIGOPADRAOENTRADACST_90', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGOPADRAOENTRADACST_90: Integer read FNCM_CODIGOPADRAOENTRADACST_90 write FNCM_CODIGOPADRAOENTRADACST_90;
    const NCM_CODIGOPADRAOENTRADACST_90_Name = 'NCM_CODIGOPADRAOENTRADACST_90';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCFG_Config)

end.
