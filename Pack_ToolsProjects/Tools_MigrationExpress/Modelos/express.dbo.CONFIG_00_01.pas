unit express.dbo.CONFIG_00_01;

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
  [Table('CONFIG_00_01', '')]
  [PrimaryKey('CFG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFG_CODIGO')]
  TDtoCONFIG_00_01 = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FCFG_CONFIGURACOES: String;
    FCFG_PORTEESTADUAL: String;
    FCFG_PORTEFEDERAL: String;
    FCFG_TIPOEMPRESA: String;
    FCFG_PATHSINTEGRA: String;
    FCFG_TITULORELATORIO: String;
    FCFG_CONVENIOSINTEGRA: Integer;
    FCFG_REGISTROSINTEGRA: String;
    FCFG_CODIGOLOJAMATRIZ: String;
    FCFG_DIASMAXDEVOLUCAO: Integer;
    FCFG_DIASPARAPROTESTAR: Integer;
    FCFG_TAXADEJUROSAOMES: Double;
    FCFG_LIMITEDIFERENCANFE: Double;
    FCFG_DIASATRASOPERMITIDO: Integer;
    FCFG_DIASBLOQUEARCLIENTE: Integer;
    FCFG_VALORMAXPESSOAFISICA: Double;
    FCFG_VALORMINFATURAMENTO: Double;
    FCFG_DIASTRAVARCLIENTEINATIVO: Integer;
    FCFG_CHEQUECLIENTEMAXPRORROGAR: Integer;
    FTAB_CODIGOPADRAO: Integer;
    FPRZ_CODIGOPADRAO: Integer;
    FBCO_CODIGOPADRAO: Integer;
    FFPG_CODIGOPADRAO: Integer;
    FCTA_CODIGOPADRAO: Integer;
    FVND_CODIGOPADRAO: Integer;
    FCLI_CODIGOPADRAO: Integer;
    FTDC_CODIGOPADRAO: String;
    FCFG_TOTALGGFDIARIOPRODUCAO: Double;
    FCFG_RATEIOPRODUCAO: String;
    FCFG_PATHEXPORTACAOXML: String;
    FCFG_DATAALTERACAO: TDateTime;
    FCLI_INTEGRACAOCONTABIL: String;
    FFOR_INTEGRACAOCONTABIL: String;
    FCTA_CODIGOPADRAOCHEQUEPENDENTE: Integer;
    FNTO_CODIGOPADRAOCOMPRA: Integer;
    FNTO_CODIGOPADRAOVENDA: Integer;
    FNTO_CODIGOPADRAOVENDACPF: Integer;
    FCST_CODIGOPADRAO: String;
    FCFG_PATHEXPORTACAOCONTABIL: String;
    FCFG_PERCENTUALMAXDESCTO: Double;
    FCFG_PERCENTUALCONTSOCIALMKP: Double;
    FCFG_PERCENTUALCOMISSAOVNDMKP: Double;
    FCFG_PERCENTUALIMPOSTORENDAMKP: Double;
    FCFG_PERCENTUALADMINISTRATIVOMKP: Double;
    FCFG_PERCENTUALSIMPLESMKP_1: Double;
    FCFG_PERCENTUALSIMPLESMKP_2: Double;
    FCFG_MSGBOLETO1: String;
    FCFG_MSGBOLETO2: String;
    FCFG_MSGBOLETO3: String;
    FCFG_MSGBOLETO4: String;
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
    FCFG_DIASBLOQUEIOPALM_BOL: Integer;
    FCFG_DIASBLOQUEIOPALM_CHE: Integer;
    FCFG_DIASBLOQUEIOPALM_CAR: Integer;
    FTRP_CODIGOPADRAO: Integer;
    FPOR_CODIGOPADRAO: Integer;
    FCFG_EMAILSERVIDORENVIO: String;
    FCFG_EMAILENVIO: String;
    FCFG_EMAILUSUARIOENVIO: String;
    FCFG_EMAILSENHAENVIO: String;
    FCFG_EMAILPORTAENVIO: Integer;
    FCFG_EMAILSSL: String;
    FCFG_MENSAGEMCARTACOBRANCA1: String;
    FCFG_MENSAGEMCARTACOBRANCA2: String;
    FGRP_CODIGOPADRAO: Integer;
    FSGP_CODIGOPADRAO: Integer;
    FCFG_TIPOIMPRESSAODOCTOBOLETO: String;
    FCFG_IBPTCHAVE: String;
    FCFG_IBPTVERSAO: String;
    FCFG_QTDCASADECIMALVALORUNITARIO: Integer;
    FCFG_DIASVALIDADEORCAMENTO: Integer;
    FCFG_CONFIGURACAOIMPRESSAOVENDA: String;
    FCFG_SENHALIBERACAOVENDA: String;
    FNTO_CODIGOPADRAOSERVICO: Integer;
    FCFG_VALORTOLERANCIADESCTO: Double;
    FCFG_VALORMINIMOPARCELAMENTO: Double;
    FCFG_MARKUPMINVENDA: Double;
    FCFG_QTDCASADECIMALQUANTIDADE: Integer;
    FCFG_TIPOFRETE: String;
    FCFG_ESTOQUERESERVASAIDA: String;
    FCFG_TIPOSELECAOPRODUTO: String;
    FCFG_EXIBICAOCAMPOSDIGPRODUTO: String;
    FCFG_PERCENTUALMARGEMLUCRO: Double;
    FCTA_CODIGOPADRAOANTECIPACAOFOR: Integer;
    FCTA_CODIGOPADRAOANTECIPACAOCLI: Integer;
    FCFG_EMAILTLS: String;
    FNTO_CODIGOPADRAODEVOLUCAO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CONFIG_00_01';
     const PrimaryKey = 'CFG_CODIGO';
     const Sequence   = 'SEQ_CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFG_CONFIGURACOES', ftString, 100)]
    [Dictionary('CFG_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CONFIGURACOES: String read FCFG_CONFIGURACOES write FCFG_CONFIGURACOES;
    const CFG_CONFIGURACOES_Name = 'CFG_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('CFG_PORTEESTADUAL', ftString, 1)]
    [Dictionary('CFG_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PORTEESTADUAL: String read FCFG_PORTEESTADUAL write FCFG_PORTEESTADUAL;
    const CFG_PORTEESTADUAL_Name = 'CFG_PORTEESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CFG_PORTEFEDERAL', ftString, 1)]
    [Dictionary('CFG_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PORTEFEDERAL: String read FCFG_PORTEFEDERAL write FCFG_PORTEFEDERAL;
    const CFG_PORTEFEDERAL_Name = 'CFG_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOEMPRESA', ftString, 1)]
    [Dictionary('CFG_TIPOEMPRESA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOEMPRESA: String read FCFG_TIPOEMPRESA write FCFG_TIPOEMPRESA;
    const CFG_TIPOEMPRESA_Name = 'CFG_TIPOEMPRESA';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHSINTEGRA', ftString, 300)]
    [Dictionary('CFG_PATHSINTEGRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHSINTEGRA: String read FCFG_PATHSINTEGRA write FCFG_PATHSINTEGRA;
    const CFG_PATHSINTEGRA_Name = 'CFG_PATHSINTEGRA';

    [Restrictions([NoValidate])]
    [Column('CFG_TITULORELATORIO', ftString, 50)]
    [Dictionary('CFG_TITULORELATORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TITULORELATORIO: String read FCFG_TITULORELATORIO write FCFG_TITULORELATORIO;
    const CFG_TITULORELATORIO_Name = 'CFG_TITULORELATORIO';

    [Restrictions([NoValidate])]
    [Column('CFG_CONVENIOSINTEGRA', ftInteger)]
    [Dictionary('CFG_CONVENIOSINTEGRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CONVENIOSINTEGRA: Integer read FCFG_CONVENIOSINTEGRA write FCFG_CONVENIOSINTEGRA;
    const CFG_CONVENIOSINTEGRA_Name = 'CFG_CONVENIOSINTEGRA';

    [Restrictions([NoValidate])]
    [Column('CFG_REGISTROSINTEGRA', ftString, 30)]
    [Dictionary('CFG_REGISTROSINTEGRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_REGISTROSINTEGRA: String read FCFG_REGISTROSINTEGRA write FCFG_REGISTROSINTEGRA;
    const CFG_REGISTROSINTEGRA_Name = 'CFG_REGISTROSINTEGRA';

    [Restrictions([NoValidate])]
    [Column('CFG_CODIGOLOJAMATRIZ', ftString, 3)]
    [Dictionary('CFG_CODIGOLOJAMATRIZ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CODIGOLOJAMATRIZ: String read FCFG_CODIGOLOJAMATRIZ write FCFG_CODIGOLOJAMATRIZ;
    const CFG_CODIGOLOJAMATRIZ_Name = 'CFG_CODIGOLOJAMATRIZ';

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
    [Column('CFG_TAXADEJUROSAOMES', ftBCD)]
    [Dictionary('CFG_TAXADEJUROSAOMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_TAXADEJUROSAOMES: Double read FCFG_TAXADEJUROSAOMES write FCFG_TAXADEJUROSAOMES;
    const CFG_TAXADEJUROSAOMES_Name = 'CFG_TAXADEJUROSAOMES';

    [Restrictions([NoValidate])]
    [Column('CFG_LIMITEDIFERENCANFE', ftBCD)]
    [Dictionary('CFG_LIMITEDIFERENCANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_LIMITEDIFERENCANFE: Double read FCFG_LIMITEDIFERENCANFE write FCFG_LIMITEDIFERENCANFE;
    const CFG_LIMITEDIFERENCANFE_Name = 'CFG_LIMITEDIFERENCANFE';

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
    [Column('CFG_VALORMAXPESSOAFISICA', ftBCD)]
    [Dictionary('CFG_VALORMAXPESSOAFISICA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORMAXPESSOAFISICA: Double read FCFG_VALORMAXPESSOAFISICA write FCFG_VALORMAXPESSOAFISICA;
    const CFG_VALORMAXPESSOAFISICA_Name = 'CFG_VALORMAXPESSOAFISICA';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORMINFATURAMENTO', ftBCD)]
    [Dictionary('CFG_VALORMINFATURAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORMINFATURAMENTO: Double read FCFG_VALORMINFATURAMENTO write FCFG_VALORMINFATURAMENTO;
    const CFG_VALORMINFATURAMENTO_Name = 'CFG_VALORMINFATURAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASTRAVARCLIENTEINATIVO', ftInteger)]
    [Dictionary('CFG_DIASTRAVARCLIENTEINATIVO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASTRAVARCLIENTEINATIVO: Integer read FCFG_DIASTRAVARCLIENTEINATIVO write FCFG_DIASTRAVARCLIENTEINATIVO;
    const CFG_DIASTRAVARCLIENTEINATIVO_Name = 'CFG_DIASTRAVARCLIENTEINATIVO';

    [Restrictions([NoValidate])]
    [Column('CFG_CHEQUECLIENTEMAXPRORROGAR', ftInteger)]
    [Dictionary('CFG_CHEQUECLIENTEMAXPRORROGAR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CHEQUECLIENTEMAXPRORROGAR: Integer read FCFG_CHEQUECLIENTEMAXPRORROGAR write FCFG_CHEQUECLIENTEMAXPRORROGAR;
    const CFG_CHEQUECLIENTEMAXPRORROGAR_Name = 'CFG_CHEQUECLIENTEMAXPRORROGAR';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGOPADRAO', ftInteger)]
    [Dictionary('TAB_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGOPADRAO: Integer read FTAB_CODIGOPADRAO write FTAB_CODIGOPADRAO;
    const TAB_CODIGOPADRAO_Name = 'TAB_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGOPADRAO', ftInteger)]
    [Dictionary('PRZ_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGOPADRAO: Integer read FPRZ_CODIGOPADRAO write FPRZ_CODIGOPADRAO;
    const PRZ_CODIGOPADRAO_Name = 'PRZ_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGOPADRAO', ftInteger)]
    [Dictionary('BCO_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGOPADRAO: Integer read FBCO_CODIGOPADRAO write FBCO_CODIGOPADRAO;
    const BCO_CODIGOPADRAO_Name = 'BCO_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGOPADRAO', ftInteger)]
    [Dictionary('FPG_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGOPADRAO: Integer read FFPG_CODIGOPADRAO write FFPG_CODIGOPADRAO;
    const FPG_CODIGOPADRAO_Name = 'FPG_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOPADRAO', ftInteger)]
    [Dictionary('CTA_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOPADRAO: Integer read FCTA_CODIGOPADRAO write FCTA_CODIGOPADRAO;
    const CTA_CODIGOPADRAO_Name = 'CTA_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGOPADRAO', ftInteger)]
    [Dictionary('VND_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGOPADRAO: Integer read FVND_CODIGOPADRAO write FVND_CODIGOPADRAO;
    const VND_CODIGOPADRAO_Name = 'VND_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CLI_CODIGOPADRAO', ftInteger)]
    [Dictionary('CLI_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLI_CODIGOPADRAO: Integer read FCLI_CODIGOPADRAO write FCLI_CODIGOPADRAO;
    const CLI_CODIGOPADRAO_Name = 'CLI_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGOPADRAO', ftString, 4)]
    [Dictionary('TDC_CODIGOPADRAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGOPADRAO: String read FTDC_CODIGOPADRAO write FTDC_CODIGOPADRAO;
    const TDC_CODIGOPADRAO_Name = 'TDC_CODIGOPADRAO';

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
    [Column('CFG_PATHEXPORTACAOXML', ftString, 300)]
    [Dictionary('CFG_PATHEXPORTACAOXML', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHEXPORTACAOXML: String read FCFG_PATHEXPORTACAOXML write FCFG_PATHEXPORTACAOXML;
    const CFG_PATHEXPORTACAOXML_Name = 'CFG_PATHEXPORTACAOXML';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CLI_INTEGRACAOCONTABIL', ftString, 18)]
    [Dictionary('CLI_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLI_INTEGRACAOCONTABIL: String read FCLI_INTEGRACAOCONTABIL write FCLI_INTEGRACAOCONTABIL;
    const CLI_INTEGRACAOCONTABIL_Name = 'CLI_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('FOR_INTEGRACAOCONTABIL', ftString, 18)]
    [Dictionary('FOR_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_INTEGRACAOCONTABIL: String read FFOR_INTEGRACAOCONTABIL write FFOR_INTEGRACAOCONTABIL;
    const FOR_INTEGRACAOCONTABIL_Name = 'FOR_INTEGRACAOCONTABIL';

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
    [Column('NTO_CODIGOPADRAOVENDACPF', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAOVENDACPF', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAOVENDACPF: Integer read FNTO_CODIGOPADRAOVENDACPF write FNTO_CODIGOPADRAOVENDACPF;
    const NTO_CODIGOPADRAOVENDACPF_Name = 'NTO_CODIGOPADRAOVENDACPF';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOPADRAO', ftString, 2)]
    [Dictionary('CST_CODIGOPADRAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOPADRAO: String read FCST_CODIGOPADRAO write FCST_CODIGOPADRAO;
    const CST_CODIGOPADRAO_Name = 'CST_CODIGOPADRAO';

    [Restrictions([NoValidate])]
    [Column('CFG_PATHEXPORTACAOCONTABIL', ftString, 300)]
    [Dictionary('CFG_PATHEXPORTACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PATHEXPORTACAOCONTABIL: String read FCFG_PATHEXPORTACAOCONTABIL write FCFG_PATHEXPORTACAOCONTABIL;
    const CFG_PATHEXPORTACAOCONTABIL_Name = 'CFG_PATHEXPORTACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALMAXDESCTO', ftBCD)]
    [Dictionary('CFG_PERCENTUALMAXDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALMAXDESCTO: Double read FCFG_PERCENTUALMAXDESCTO write FCFG_PERCENTUALMAXDESCTO;
    const CFG_PERCENTUALMAXDESCTO_Name = 'CFG_PERCENTUALMAXDESCTO';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALCONTSOCIALMKP', ftBCD)]
    [Dictionary('CFG_PERCENTUALCONTSOCIALMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALCONTSOCIALMKP: Double read FCFG_PERCENTUALCONTSOCIALMKP write FCFG_PERCENTUALCONTSOCIALMKP;
    const CFG_PERCENTUALCONTSOCIALMKP_Name = 'CFG_PERCENTUALCONTSOCIALMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALCOMISSAOVNDMKP', ftBCD)]
    [Dictionary('CFG_PERCENTUALCOMISSAOVNDMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALCOMISSAOVNDMKP: Double read FCFG_PERCENTUALCOMISSAOVNDMKP write FCFG_PERCENTUALCOMISSAOVNDMKP;
    const CFG_PERCENTUALCOMISSAOVNDMKP_Name = 'CFG_PERCENTUALCOMISSAOVNDMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALIMPOSTORENDAMKP', ftBCD)]
    [Dictionary('CFG_PERCENTUALIMPOSTORENDAMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALIMPOSTORENDAMKP: Double read FCFG_PERCENTUALIMPOSTORENDAMKP write FCFG_PERCENTUALIMPOSTORENDAMKP;
    const CFG_PERCENTUALIMPOSTORENDAMKP_Name = 'CFG_PERCENTUALIMPOSTORENDAMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALADMINISTRATIVOMKP', ftBCD)]
    [Dictionary('CFG_PERCENTUALADMINISTRATIVOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALADMINISTRATIVOMKP: Double read FCFG_PERCENTUALADMINISTRATIVOMKP write FCFG_PERCENTUALADMINISTRATIVOMKP;
    const CFG_PERCENTUALADMINISTRATIVOMKP_Name = 'CFG_PERCENTUALADMINISTRATIVOMKP';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALSIMPLESMKP_1', ftBCD)]
    [Dictionary('CFG_PERCENTUALSIMPLESMKP_1', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALSIMPLESMKP_1: Double read FCFG_PERCENTUALSIMPLESMKP_1 write FCFG_PERCENTUALSIMPLESMKP_1;
    const CFG_PERCENTUALSIMPLESMKP_1_Name = 'CFG_PERCENTUALSIMPLESMKP_1';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALSIMPLESMKP_2', ftBCD)]
    [Dictionary('CFG_PERCENTUALSIMPLESMKP_2', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALSIMPLESMKP_2: Double read FCFG_PERCENTUALSIMPLESMKP_2 write FCFG_PERCENTUALSIMPLESMKP_2;
    const CFG_PERCENTUALSIMPLESMKP_2_Name = 'CFG_PERCENTUALSIMPLESMKP_2';

    [Restrictions([NoValidate])]
    [Column('CFG_MSGBOLETO1', ftString, 300)]
    [Dictionary('CFG_MSGBOLETO1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_MSGBOLETO1: String read FCFG_MSGBOLETO1 write FCFG_MSGBOLETO1;
    const CFG_MSGBOLETO1_Name = 'CFG_MSGBOLETO1';

    [Restrictions([NoValidate])]
    [Column('CFG_MSGBOLETO2', ftString, 300)]
    [Dictionary('CFG_MSGBOLETO2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_MSGBOLETO2: String read FCFG_MSGBOLETO2 write FCFG_MSGBOLETO2;
    const CFG_MSGBOLETO2_Name = 'CFG_MSGBOLETO2';

    [Restrictions([NoValidate])]
    [Column('CFG_MSGBOLETO3', ftString, 300)]
    [Dictionary('CFG_MSGBOLETO3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_MSGBOLETO3: String read FCFG_MSGBOLETO3 write FCFG_MSGBOLETO3;
    const CFG_MSGBOLETO3_Name = 'CFG_MSGBOLETO3';

    [Restrictions([NoValidate])]
    [Column('CFG_MSGBOLETO4', ftString, 300)]
    [Dictionary('CFG_MSGBOLETO4', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_MSGBOLETO4: String read FCFG_MSGBOLETO4 write FCFG_MSGBOLETO4;
    const CFG_MSGBOLETO4_Name = 'CFG_MSGBOLETO4';

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
    [Column('CFG_VRDESCTOARREDONDAMENTOPDV', ftBCD)]
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
    [Column('CFG_DIASBLOQUEIOPALM_BOL', ftInteger)]
    [Dictionary('CFG_DIASBLOQUEIOPALM_BOL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASBLOQUEIOPALM_BOL: Integer read FCFG_DIASBLOQUEIOPALM_BOL write FCFG_DIASBLOQUEIOPALM_BOL;
    const CFG_DIASBLOQUEIOPALM_BOL_Name = 'CFG_DIASBLOQUEIOPALM_BOL';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASBLOQUEIOPALM_CHE', ftInteger)]
    [Dictionary('CFG_DIASBLOQUEIOPALM_CHE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASBLOQUEIOPALM_CHE: Integer read FCFG_DIASBLOQUEIOPALM_CHE write FCFG_DIASBLOQUEIOPALM_CHE;
    const CFG_DIASBLOQUEIOPALM_CHE_Name = 'CFG_DIASBLOQUEIOPALM_CHE';

    [Restrictions([NoValidate])]
    [Column('CFG_DIASBLOQUEIOPALM_CAR', ftInteger)]
    [Dictionary('CFG_DIASBLOQUEIOPALM_CAR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASBLOQUEIOPALM_CAR: Integer read FCFG_DIASBLOQUEIOPALM_CAR write FCFG_DIASBLOQUEIOPALM_CAR;
    const CFG_DIASBLOQUEIOPALM_CAR_Name = 'CFG_DIASBLOQUEIOPALM_CAR';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGOPADRAO', ftInteger)]
    [Dictionary('TRP_CODIGOPADRAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGOPADRAO: Integer read FTRP_CODIGOPADRAO write FTRP_CODIGOPADRAO;
    const TRP_CODIGOPADRAO_Name = 'TRP_CODIGOPADRAO';

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
    [Column('CFG_DIASVALIDADEORCAMENTO', ftInteger)]
    [Dictionary('CFG_DIASVALIDADEORCAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_DIASVALIDADEORCAMENTO: Integer read FCFG_DIASVALIDADEORCAMENTO write FCFG_DIASVALIDADEORCAMENTO;
    const CFG_DIASVALIDADEORCAMENTO_Name = 'CFG_DIASVALIDADEORCAMENTO';

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
    [Column('NTO_CODIGOPADRAOSERVICO', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAOSERVICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAOSERVICO: Integer read FNTO_CODIGOPADRAOSERVICO write FNTO_CODIGOPADRAOSERVICO;
    const NTO_CODIGOPADRAOSERVICO_Name = 'NTO_CODIGOPADRAOSERVICO';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORTOLERANCIADESCTO', ftBCD)]
    [Dictionary('CFG_VALORTOLERANCIADESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORTOLERANCIADESCTO: Double read FCFG_VALORTOLERANCIADESCTO write FCFG_VALORTOLERANCIADESCTO;
    const CFG_VALORTOLERANCIADESCTO_Name = 'CFG_VALORTOLERANCIADESCTO';

    [Restrictions([NoValidate])]
    [Column('CFG_VALORMINIMOPARCELAMENTO', ftBCD)]
    [Dictionary('CFG_VALORMINIMOPARCELAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_VALORMINIMOPARCELAMENTO: Double read FCFG_VALORMINIMOPARCELAMENTO write FCFG_VALORMINIMOPARCELAMENTO;
    const CFG_VALORMINIMOPARCELAMENTO_Name = 'CFG_VALORMINIMOPARCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFG_MARKUPMINVENDA', ftBCD)]
    [Dictionary('CFG_MARKUPMINVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_MARKUPMINVENDA: Double read FCFG_MARKUPMINVENDA write FCFG_MARKUPMINVENDA;
    const CFG_MARKUPMINVENDA_Name = 'CFG_MARKUPMINVENDA';

    [Restrictions([NoValidate])]
    [Column('CFG_QTDCASADECIMALQUANTIDADE', ftInteger)]
    [Dictionary('CFG_QTDCASADECIMALQUANTIDADE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_QTDCASADECIMALQUANTIDADE: Integer read FCFG_QTDCASADECIMALQUANTIDADE write FCFG_QTDCASADECIMALQUANTIDADE;
    const CFG_QTDCASADECIMALQUANTIDADE_Name = 'CFG_QTDCASADECIMALQUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOFRETE', ftString, 1)]
    [Dictionary('CFG_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOFRETE: String read FCFG_TIPOFRETE write FCFG_TIPOFRETE;
    const CFG_TIPOFRETE_Name = 'CFG_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CFG_ESTOQUERESERVASAIDA', ftString, 1)]
    [Dictionary('CFG_ESTOQUERESERVASAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_ESTOQUERESERVASAIDA: String read FCFG_ESTOQUERESERVASAIDA write FCFG_ESTOQUERESERVASAIDA;
    const CFG_ESTOQUERESERVASAIDA_Name = 'CFG_ESTOQUERESERVASAIDA';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPOSELECAOPRODUTO', ftString, 1)]
    [Dictionary('CFG_TIPOSELECAOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPOSELECAOPRODUTO: String read FCFG_TIPOSELECAOPRODUTO write FCFG_TIPOSELECAOPRODUTO;
    const CFG_TIPOSELECAOPRODUTO_Name = 'CFG_TIPOSELECAOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('CFG_EXIBICAOCAMPOSDIGPRODUTO', ftString, 1)]
    [Dictionary('CFG_EXIBICAOCAMPOSDIGPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EXIBICAOCAMPOSDIGPRODUTO: String read FCFG_EXIBICAOCAMPOSDIGPRODUTO write FCFG_EXIBICAOCAMPOSDIGPRODUTO;
    const CFG_EXIBICAOCAMPOSDIGPRODUTO_Name = 'CFG_EXIBICAOCAMPOSDIGPRODUTO';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALMARGEMLUCRO', ftBCD)]
    [Dictionary('CFG_PERCENTUALMARGEMLUCRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALMARGEMLUCRO: Double read FCFG_PERCENTUALMARGEMLUCRO write FCFG_PERCENTUALMARGEMLUCRO;
    const CFG_PERCENTUALMARGEMLUCRO_Name = 'CFG_PERCENTUALMARGEMLUCRO';

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
    [Column('CFG_EMAILTLS', ftString, 1)]
    [Dictionary('CFG_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_EMAILTLS: String read FCFG_EMAILTLS write FCFG_EMAILTLS;
    const CFG_EMAILTLS_Name = 'CFG_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOPADRAODEVOLUCAO', ftInteger)]
    [Dictionary('NTO_CODIGOPADRAODEVOLUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGOPADRAODEVOLUCAO: Integer read FNTO_CODIGOPADRAODEVOLUCAO write FNTO_CODIGOPADRAODEVOLUCAO;
    const NTO_CODIGOPADRAODEVOLUCAO_Name = 'NTO_CODIGOPADRAODEVOLUCAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONFIG_00_01)

end.
