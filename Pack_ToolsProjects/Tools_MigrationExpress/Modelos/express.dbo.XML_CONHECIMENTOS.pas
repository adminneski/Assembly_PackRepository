unit express.dbo.XML_CONHECIMENTOS;

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
  [Table('XML_CONHECIMENTOS', '')]
  TDtoXML_CONHECIMENTOS = class
  private
    { Private declarations } 
    FCT_TIPO: String;
    FCT_ID: Integer;
    FCOM_CODIGO: Integer;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FNTO_CODIGO: Integer;
    FNTO_ENVIARDIFAL: String;
    FNTO_ENVIARDIFALZERADO: String;
    FNTO_PERCENTUALPOBREZADIFAL: Double;
    FNTO_PERCENTUALPARTILHADIFALREM: Integer;
    FNTO_PERCENTUALPARTILHADIFALDEST: Integer;
    FNTO_PARAMETROS: String;
    FNTO_DESCRICAO: String;
    FPRO_CODIGO: Integer;
    FSGM_CODIGO: String;
    FPRO_DESCRICAO: String;
    FCT_DATAEMISSAO: TDateTime;
    FCT_DATAENTREGA: TDateTime;
    FCT_DATASAIDAENTRADA: TDateTime;
    FCT_SITUACAO: String;
    FCT_FINALIDADE: String;
    FCT_NOTAFISCAL: String;
    FCT_SERIE: String;
    FCT_RNTRC: String;
    FCT_APOLICE: String;
    FCT_NUMEROCIOT: String;
    FCT_TOTALIPI: Double;
    FCT_TOTALPIS: Double;
    FCT_TOTALICMS: Double;
    FCT_TIPOFRETE: String;
    FCT_TOTALICMSR: Double;
    FCT_TOTALCOFINS: Double;
    FCT_TOTALSEGURO: Double;
    FCT_TOTALDESCTO: Double;
    FCT_TOTALPEDAGIO: Double;
    FCT_TOTALSERVICO: Double;
    FCT_TOTALFRETENF: Double;
    FCT_TOTALDESPACHO: Double;
    FCT_TOTALPRODUTOS: Double;
    FCT_TOTALNOTAFISCAL: Double;
    FCT_TOTALNOTAFISCALCTR: Double;
    FCT_TOTALPESOBRUTO: Double;
    FCT_TOTALPESOLIQUIDO: Double;
    FCT_TOTALDESPACESSORIA: Double;
    FCT_TOTALBASEISENTOICMS: Double;
    FCT_TOTALBASECALCULOMVA: Double;
    FCT_TOTALBASECALCULOICMS: Double;
    FCT_PERCENTUALICMS: Double;
    FCT_TOTALNUMEROVOLUMES: Integer;
    FCT_NUMERACAOVOLUMES: String;
    FCT_INFCOMPLEMENTAR: String;
    FCT_ESPECIEVOLUMES: String;
    FCT_MARCAVOLUMES: String;
    FCT_INTEGRACAO: String;
    FCT_INTEGRACAOLIVRO: String;
    FCT_STATUSNFe: String;
    FCT_PORTEESTADUAL: String;
    FCT_PORTEFEDERAL: String;
    FCST_CODIGOCTR: String;
    FCT_TOTALIBPTESTADUAL: Double;
    FCT_TOTALIBPTNACIONAL: Double;
    FCT_OBSERVACAO: String;
    FCT_NUMEROLIBERACAOSEGURO: String;
    FCT_TOTALMERCADORIASEGURADA: Double;
    FCT_TIPOCTE: String;
    FCT_TIPOSERVICO: String;
    FCT_CHAVEACESSOSUBSTITUIDO: String;
    FCT_TOMADORCONTRIBUINTEICMS: String;
    FCT_CHAVEACESSOTOMADOR: String;
    FCT_CNPJTOMADOR: String;
    FCT_CPFTOMADOR: String;
    FMNF_CODIGOTOMADOR: String;
    FCT_SERIETOMADOR: String;
    FCT_SUBSERIETOMADOR: String;
    FCT_NOTAFISCALTOMADOR: String;
    FCT_VALORNOTAFISCALTOMADOR: Double;
    FCT_DATAEMISSAONFTOMADOR: TDateTime;
    FCT_CHAVEACESSOCOMPLEMENTO: String;
    FCT_CHAVEACESSOANULACAO: String;
    FCT_DATAEMISSAODECLARACAO: TDateTime;
    FCID_IBGEORIGEM: Integer;
    FCT_CIDADEORIGEM: String;
    FCT_UFORIGEM: String;
    FCID_IBGEDESTINO: Integer;
    FCT_CIDADEDESTINO: String;
    FCT_UFDESTINO: String;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FVEI_PLACA_01: String;
    FVEI_PLACA_02: String;
    FVEI_PLACA_03: String;
    FVEI_CIDADE: String;
    FVEI_UF: String;
    FVEI_NOMEMARCA: String;
    FPES_TRP: Integer;
    FPES_TIPOPESSOA_TRP: String;
    FPES_NOME_TRP: String;
    FPES_CNPJ_CPF_TRP: String;
    FPES_IE_RG_TRP: String;
    FPES_HABILITACAO_TRP: String;
    FPES_DATAEMISSAOHABILITACAO_TRP: TDateTime;
    FPES_CEP_TRP: String;
    FCID_IBGE_TRP: String;
    FPES_CIDADE_TRP: String;
    FPES_UF_TRP: String;
    FPES_ENDERECO_TRP: String;
    FPES_NUMEROENDERECO_TRP: String;
    FPES_BAIRRO_TRP: String;
    FPES_DDD_TELEFONE_1_TRP: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_TIPOPESSOA_CLIENTEREMETENTE: String;
    FPES_NOMECLIENTEREMETENTE: String;
    FPES_FANTASIA_OU_APELIDOREMETENTE: String;
    FPES_CNPJ_CPF_CLIENTEREMETENTE: String;
    FPES_IE_RG_CLIENTEREMETENTE: String;
    FPES_CEP_CLIENTEREMETENTE: String;
    FCID_IBGE_CLIENTEREMETENTE: String;
    FPES_CIDADE_CLIENTEREMETENTE: String;
    FPES_UF_CLIENTEREMETENTE: String;
    FPES_CODIGOPAIS_CLIENTEREMETENTE: String;
    FPES_PAIS_CLIENTEREMETENTE: String;
    FPES_ENDERECO_CLIENTEREMETENTE: String;
    FPES_PONTOREFERENCIA_CLIENTEREMETENTE: String;
    FPES_NUMEROENDERECO_CLIENTEREMETENTE: String;
    FPES_BAIRRO_CLIENTEREMETENTE: String;
    FPES_DDD_TELEFONE_1_CLIENTEREMETENTE: String;
    FPES_TIPOCLIENTE_CLIENTEREMETENTE: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_TIPOPESSOA_CLIENTEDESTINATARIO: String;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_CNPJ_CPF_CLIENTEDESTINATARIO: String;
    FPES_IE_RG_CLIENTEDESTINATARIO: String;
    FPES_CEP_CLIENTEDESTINATARIO: String;
    FCID_IBGE_CLIENTEDESTINATARIO: String;
    FPES_CIDADE_CLIENTEDESTINATARIO: String;
    FPES_UF_CLIENTEDESTINATARIO: String;
    FPES_CODIGOPAIS_CLIENTEDESTINATARIO: String;
    FPES_PAIS_CLIENTEDESTINATARIO: String;
    FPES_ENDERECO_CLIENTEDESTINATARIO: String;
    FPES_PONTOREFERENCIA_CLIENTEDESTINATARIO: String;
    FPES_NUMEROENDERECO_CLIENTEDESTINATARIO: String;
    FPES_BAIRRO_CLIENTEDESTINATARIO: String;
    FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO: String;
    FPES_TIPOCLIENTE_CLIENTEDESTINATARIO: String;
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_TIPOPESSOA_CLIENTECONSIGNATARIO: String;
    FPES_NOMECLIENTECONSIGNATARIO: String;
    FPES_CNPJ_CPF_CLIENTECONSIGNATARIO: String;
    FPES_IE_RG_CLIENTECONSIGNATARIO: String;
    FPES_CEP_CLIENTECONSIGNATARIO: String;
    FCID_IBGE_CLIENTECONSIGNATARIO: String;
    FPES_CIDADE_CLIENTECONSIGNATARIO: String;
    FPES_UF_CLIENTECONSIGNATARIO: String;
    FPES_CODIGOPAIS_CLIENTECONSIGNATARIO: String;
    FPES_PAIS_CLIENTECONSIGNATARIO: String;
    FPES_ENDERECO_CLIENTECONSIGNATARIO: String;
    FPES_NUMEROENDERECO_CLIENTECONSIGNATARIO: String;
    FPES_BAIRRO_CLIENTECONSIGNATARIO: String;
    FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO: String;
    FPES_TIPOCLIENTE_CLIENTECONSIGNATARIO: String;
    FPES_CLIENTEREDESPACHO: Integer;
    FPES_TIPOPESSOA_CLIENTEREDESPACHO: String;
    FPES_NOMECLIENTEREDESPACHO: String;
    FPES_CNPJ_CPF_CLIENTEREDESPACHO: String;
    FPES_IE_RG_CLIENTEREDESPACHO: String;
    FPES_CEP_CLIENTEREDESPACHO: String;
    FCID_IBGE_CLIENTEREDESPACHO: String;
    FPES_CIDADE_CLIENTEREDESPACHO: String;
    FPES_UF_CLIENTEREDESPACHO: String;
    FPES_CODIGOPAIS_CLIENTEREDESPACHO: String;
    FPES_PAIS_CLIENTEREDESPACHO: String;
    FPES_ENDERECO_CLIENTEREDESPACHO: String;
    FPES_NUMEROENDERECO_CLIENTEREDESPACHO: String;
    FPES_BAIRRO_CLIENTEREDESPACHO: String;
    FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO: String;
    FPES_TIPOCLIENTE_CLIENTEREDESPACHO: String;
    FPES_CLIENTEOUTROS: Integer;
    FPES_TIPOPESSOA_CLIENTEOUTROS: String;
    FPES_NOMECLIENTEOUTROS: String;
    FPES_CNPJ_CPF_CLIENTEOUTROS: String;
    FPES_IE_RG_CLIENTEOUTROS: String;
    FPES_CEP_CLIENTEOUTROS: String;
    FCID_IBGE_CLIENTEOUTROS: String;
    FPES_CIDADE_CLIENTEOUTROS: String;
    FPES_UF_CLIENTEOUTROS: String;
    FPES_CODIGOPAIS_CLIENTEOUTROS: String;
    FPES_PAIS_CLIENTEOUTROS: String;
    FPES_ENDERECO_CLIENTEOUTROS: String;
    FPES_NUMEROENDERECO_CLIENTEOUTROS: String;
    FPES_BAIRRO_CLIENTEOUTROS: String;
    FPES_DDD_TELEFONE_1_CLIENTEOUTROS: String;
    FPES_TIPOCLIENTE_CLIENTEOUTROS: String;
    FPES_PROPRITARIO_VEI: Integer;
    FPES_TIPOPESSOA_PROPRITARIO_VEI: String;
    FPES_NOME_PROPRITARIO_VEI: String;
    FPES_CNPJ_CPF_PROPRITARIO_VEI: String;
    FPES_IE_RG_PROPRITARIO_VEI: String;
    FPES_CEP_PROPRITARIO_VEI: String;
    FCID_IBGE_PROPRITARIO_VEI: String;
    FPES_CIDADE_PROPRITARIO_VEI: String;
    FPES_UF_PROPRITARIO_VEI: String;
    FPES_ENDERECO_PROPRITARIO_VEI: String;
    FPES_NUMEROENDERECO_PROPRITARIO_VEI: String;
    FPES_BAIRRO_PROPRITARIO_VEI: String;
    FPES_DDD_TELEFONE_1_PROPRITARIO_VEI: String;
    FPES_RNTRC_PROPRITARIO_VEI: String;
    FFOR_CODIGO: Integer;
    FFOR_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'XML_CONHECIMENTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TIPO', ftString, 3)]
    [Dictionary('CT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_TIPO: String read FCT_TIPO write FCT_TIPO;
    const CT_TIPO_Name = 'CT_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_ID', ftInteger)]
    [Dictionary('CT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CT_ID: Integer read FCT_ID write FCT_ID;
    const CT_ID_Name = 'CT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_ENVIARDIFAL', ftString, 1)]
    [Dictionary('NTO_ENVIARDIFAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ENVIARDIFAL: String read FNTO_ENVIARDIFAL write FNTO_ENVIARDIFAL;
    const NTO_ENVIARDIFAL_Name = 'NTO_ENVIARDIFAL';

    [Restrictions([NoValidate])]
    [Column('NTO_ENVIARDIFALZERADO', ftString, 1)]
    [Dictionary('NTO_ENVIARDIFALZERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ENVIARDIFALZERADO: String read FNTO_ENVIARDIFALZERADO write FNTO_ENVIARDIFALZERADO;
    const NTO_ENVIARDIFALZERADO_Name = 'NTO_ENVIARDIFALZERADO';

    [Restrictions([NoValidate])]
    [Column('NTO_PERCENTUALPOBREZADIFAL', ftBCD, 221996910, 2)]
    [Dictionary('NTO_PERCENTUALPOBREZADIFAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NTO_PERCENTUALPOBREZADIFAL: Double read FNTO_PERCENTUALPOBREZADIFAL write FNTO_PERCENTUALPOBREZADIFAL;
    const NTO_PERCENTUALPOBREZADIFAL_Name = 'NTO_PERCENTUALPOBREZADIFAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_PERCENTUALPARTILHADIFALREM', ftInteger)]
    [Dictionary('NTO_PERCENTUALPARTILHADIFALREM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_PERCENTUALPARTILHADIFALREM: Integer read FNTO_PERCENTUALPARTILHADIFALREM write FNTO_PERCENTUALPARTILHADIFALREM;
    const NTO_PERCENTUALPARTILHADIFALREM_Name = 'NTO_PERCENTUALPARTILHADIFALREM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_PERCENTUALPARTILHADIFALDEST', ftInteger)]
    [Dictionary('NTO_PERCENTUALPARTILHADIFALDEST', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_PERCENTUALPARTILHADIFALDEST: Integer read FNTO_PERCENTUALPARTILHADIFALDEST write FNTO_PERCENTUALPARTILHADIFALDEST;
    const NTO_PERCENTUALPARTILHADIFALDEST_Name = 'NTO_PERCENTUALPARTILHADIFALDEST';

    [Restrictions([NoValidate])]
    [Column('NTO_PARAMETROS', ftString, 50)]
    [Dictionary('NTO_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_PARAMETROS: String read FNTO_PARAMETROS write FNTO_PARAMETROS;
    const NTO_PARAMETROS_Name = 'NTO_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CT_DATAEMISSAO', ftDateTime)]
    [Dictionary('CT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CT_DATAEMISSAO: TDateTime read FCT_DATAEMISSAO write FCT_DATAEMISSAO;
    const CT_DATAEMISSAO_Name = 'CT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CT_DATAENTREGA', ftDateTime)]
    [Dictionary('CT_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CT_DATAENTREGA: TDateTime read FCT_DATAENTREGA write FCT_DATAENTREGA;
    const CT_DATAENTREGA_Name = 'CT_DATAENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_DATASAIDAENTRADA', ftDateTime)]
    [Dictionary('CT_DATASAIDAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CT_DATASAIDAENTRADA: TDateTime read FCT_DATASAIDAENTRADA write FCT_DATASAIDAENTRADA;
    const CT_DATASAIDAENTRADA_Name = 'CT_DATASAIDAENTRADA';

    [Restrictions([NoValidate])]
    [Column('CT_SITUACAO', ftString, 1)]
    [Dictionary('CT_SITUACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_SITUACAO: String read FCT_SITUACAO write FCT_SITUACAO;
    const CT_SITUACAO_Name = 'CT_SITUACAO';

    [Restrictions([NoValidate])]
    [Column('CT_FINALIDADE', ftString, 1)]
    [Dictionary('CT_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_FINALIDADE: String read FCT_FINALIDADE write FCT_FINALIDADE;
    const CT_FINALIDADE_Name = 'CT_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('CT_NOTAFISCAL', ftString, 9)]
    [Dictionary('CT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NOTAFISCAL: String read FCT_NOTAFISCAL write FCT_NOTAFISCAL;
    const CT_NOTAFISCAL_Name = 'CT_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_SERIE', ftString, 3)]
    [Dictionary('CT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_SERIE: String read FCT_SERIE write FCT_SERIE;
    const CT_SERIE_Name = 'CT_SERIE';

    [Restrictions([NoValidate])]
    [Column('CT_RNTRC', ftString, 14)]
    [Dictionary('CT_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_RNTRC: String read FCT_RNTRC write FCT_RNTRC;
    const CT_RNTRC_Name = 'CT_RNTRC';

    [Restrictions([NoValidate])]
    [Column('CT_APOLICE', ftString, 20)]
    [Dictionary('CT_APOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_APOLICE: String read FCT_APOLICE write FCT_APOLICE;
    const CT_APOLICE_Name = 'CT_APOLICE';

    [Restrictions([NoValidate])]
    [Column('CT_NUMEROCIOT', ftString, 12)]
    [Dictionary('CT_NUMEROCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NUMEROCIOT: String read FCT_NUMEROCIOT write FCT_NUMEROCIOT;
    const CT_NUMEROCIOT_Name = 'CT_NUMEROCIOT';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALIPI', ftBCD)]
    [Dictionary('CT_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALIPI: Double read FCT_TOTALIPI write FCT_TOTALIPI;
    const CT_TOTALIPI_Name = 'CT_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALPIS', ftBCD, 5111903, 2)]
    [Dictionary('CT_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALPIS: Double read FCT_TOTALPIS write FCT_TOTALPIS;
    const CT_TOTALPIS_Name = 'CT_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALICMS', ftBCD)]
    [Dictionary('CT_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALICMS: Double read FCT_TOTALICMS write FCT_TOTALICMS;
    const CT_TOTALICMS_Name = 'CT_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('CT_TIPOFRETE', ftString, 1)]
    [Dictionary('CT_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_TIPOFRETE: String read FCT_TIPOFRETE write FCT_TIPOFRETE;
    const CT_TIPOFRETE_Name = 'CT_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALICMSR', ftBCD, 5636178, 2)]
    [Dictionary('CT_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALICMSR: Double read FCT_TOTALICMSR write FCT_TOTALICMSR;
    const CT_TOTALICMSR_Name = 'CT_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALCOFINS', ftBCD)]
    [Dictionary('CT_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALCOFINS: Double read FCT_TOTALCOFINS write FCT_TOTALCOFINS;
    const CT_TOTALCOFINS_Name = 'CT_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALSEGURO', ftBCD)]
    [Dictionary('CT_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALSEGURO: Double read FCT_TOTALSEGURO write FCT_TOTALSEGURO;
    const CT_TOTALSEGURO_Name = 'CT_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALDESCTO', ftBCD, 16387, 2)]
    [Dictionary('CT_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALDESCTO: Double read FCT_TOTALDESCTO write FCT_TOTALDESCTO;
    const CT_TOTALDESCTO_Name = 'CT_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALPEDAGIO', ftBCD, 16387, 2)]
    [Dictionary('CT_TOTALPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALPEDAGIO: Double read FCT_TOTALPEDAGIO write FCT_TOTALPEDAGIO;
    const CT_TOTALPEDAGIO_Name = 'CT_TOTALPEDAGIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALSERVICO', ftBCD, 300, 2)]
    [Dictionary('CT_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALSERVICO: Double read FCT_TOTALSERVICO write FCT_TOTALSERVICO;
    const CT_TOTALSERVICO_Name = 'CT_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALFRETENF', ftBCD)]
    [Dictionary('CT_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALFRETENF: Double read FCT_TOTALFRETENF write FCT_TOTALFRETENF;
    const CT_TOTALFRETENF_Name = 'CT_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALDESPACHO', ftBCD)]
    [Dictionary('CT_TOTALDESPACHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALDESPACHO: Double read FCT_TOTALDESPACHO write FCT_TOTALDESPACHO;
    const CT_TOTALDESPACHO_Name = 'CT_TOTALDESPACHO';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALPRODUTOS', ftBCD)]
    [Dictionary('CT_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALPRODUTOS: Double read FCT_TOTALPRODUTOS write FCT_TOTALPRODUTOS;
    const CT_TOTALPRODUTOS_Name = 'CT_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CT_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALNOTAFISCAL: Double read FCT_TOTALNOTAFISCAL write FCT_TOTALNOTAFISCAL;
    const CT_TOTALNOTAFISCAL_Name = 'CT_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALNOTAFISCALCTR', ftBCD)]
    [Dictionary('CT_TOTALNOTAFISCALCTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALNOTAFISCALCTR: Double read FCT_TOTALNOTAFISCALCTR write FCT_TOTALNOTAFISCALCTR;
    const CT_TOTALNOTAFISCALCTR_Name = 'CT_TOTALNOTAFISCALCTR';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CT_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALPESOBRUTO: Double read FCT_TOTALPESOBRUTO write FCT_TOTALPESOBRUTO;
    const CT_TOTALPESOBRUTO_Name = 'CT_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CT_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALPESOLIQUIDO: Double read FCT_TOTALPESOLIQUIDO write FCT_TOTALPESOLIQUIDO;
    const CT_TOTALPESOLIQUIDO_Name = 'CT_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('CT_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALDESPACESSORIA: Double read FCT_TOTALDESPACESSORIA write FCT_TOTALDESPACESSORIA;
    const CT_TOTALDESPACESSORIA_Name = 'CT_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALBASEISENTOICMS', ftBCD, 1952867660, 2)]
    [Dictionary('CT_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALBASEISENTOICMS: Double read FCT_TOTALBASEISENTOICMS write FCT_TOTALBASEISENTOICMS;
    const CT_TOTALBASEISENTOICMS_Name = 'CT_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALBASECALCULOMVA', ftBCD, 1195983951, 2)]
    [Dictionary('CT_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALBASECALCULOMVA: Double read FCT_TOTALBASECALCULOMVA write FCT_TOTALBASECALCULOMVA;
    const CT_TOTALBASECALCULOMVA_Name = 'CT_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALBASECALCULOICMS', ftBCD, 1869770784, 2)]
    [Dictionary('CT_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALBASECALCULOICMS: Double read FCT_TOTALBASECALCULOICMS write FCT_TOTALBASECALCULOICMS;
    const CT_TOTALBASECALCULOICMS_Name = 'CT_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('CT_PERCENTUALICMS', ftBCD, 4522064, 2)]
    [Dictionary('CT_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_PERCENTUALICMS: Double read FCT_PERCENTUALICMS write FCT_PERCENTUALICMS;
    const CT_PERCENTUALICMS_Name = 'CT_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('CT_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CT_TOTALNUMEROVOLUMES: Integer read FCT_TOTALNUMEROVOLUMES write FCT_TOTALNUMEROVOLUMES;
    const CT_TOTALNUMEROVOLUMES_Name = 'CT_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CT_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('CT_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NUMERACAOVOLUMES: String read FCT_NUMERACAOVOLUMES write FCT_NUMERACAOVOLUMES;
    const CT_NUMERACAOVOLUMES_Name = 'CT_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CT_INFCOMPLEMENTAR', ftString, 5000)]
    [Dictionary('CT_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_INFCOMPLEMENTAR: String read FCT_INFCOMPLEMENTAR write FCT_INFCOMPLEMENTAR;
    const CT_INFCOMPLEMENTAR_Name = 'CT_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('CT_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('CT_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_ESPECIEVOLUMES: String read FCT_ESPECIEVOLUMES write FCT_ESPECIEVOLUMES;
    const CT_ESPECIEVOLUMES_Name = 'CT_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CT_MARCAVOLUMES', ftString, 30)]
    [Dictionary('CT_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_MARCAVOLUMES: String read FCT_MARCAVOLUMES write FCT_MARCAVOLUMES;
    const CT_MARCAVOLUMES_Name = 'CT_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CT_INTEGRACAO', ftString, 20)]
    [Dictionary('CT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_INTEGRACAO: String read FCT_INTEGRACAO write FCT_INTEGRACAO;
    const CT_INTEGRACAO_Name = 'CT_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CT_INTEGRACAOLIVRO', ftString, 33)]
    [Dictionary('CT_INTEGRACAOLIVRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_INTEGRACAOLIVRO: String read FCT_INTEGRACAOLIVRO write FCT_INTEGRACAOLIVRO;
    const CT_INTEGRACAOLIVRO_Name = 'CT_INTEGRACAOLIVRO';

    [Restrictions([NoValidate])]
    [Column('CT_STATUSNFe', ftString, 2)]
    [Dictionary('CT_STATUSNFe', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_STATUSNFe: String read FCT_STATUSNFe write FCT_STATUSNFe;
    const CT_STATUSNFe_Name = 'CT_STATUSNFe';

    [Restrictions([NoValidate])]
    [Column('CT_PORTEESTADUAL', ftString, 1)]
    [Dictionary('CT_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_PORTEESTADUAL: String read FCT_PORTEESTADUAL write FCT_PORTEESTADUAL;
    const CT_PORTEESTADUAL_Name = 'CT_PORTEESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CT_PORTEFEDERAL', ftString, 1)]
    [Dictionary('CT_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_PORTEFEDERAL: String read FCT_PORTEFEDERAL write FCT_PORTEFEDERAL;
    const CT_PORTEFEDERAL_Name = 'CT_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOCTR', ftString, 2)]
    [Dictionary('CST_CODIGOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOCTR: String read FCST_CODIGOCTR write FCST_CODIGOCTR;
    const CST_CODIGOCTR_Name = 'CST_CODIGOCTR';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALIBPTESTADUAL', ftBCD, 1380275039, 2)]
    [Dictionary('CT_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALIBPTESTADUAL: Double read FCT_TOTALIBPTESTADUAL write FCT_TOTALIBPTESTADUAL;
    const CT_TOTALIBPTESTADUAL_Name = 'CT_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALIBPTNACIONAL', ftBCD, 659507017, 2)]
    [Dictionary('CT_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALIBPTNACIONAL: Double read FCT_TOTALIBPTNACIONAL write FCT_TOTALIBPTNACIONAL;
    const CT_TOTALIBPTNACIONAL_Name = 'CT_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('CT_OBSERVACAO', ftString, 5000)]
    [Dictionary('CT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_OBSERVACAO: String read FCT_OBSERVACAO write FCT_OBSERVACAO;
    const CT_OBSERVACAO_Name = 'CT_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CT_NUMEROLIBERACAOSEGURO', ftString, 20)]
    [Dictionary('CT_NUMEROLIBERACAOSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NUMEROLIBERACAOSEGURO: String read FCT_NUMEROLIBERACAOSEGURO write FCT_NUMEROLIBERACAOSEGURO;
    const CT_NUMEROLIBERACAOSEGURO_Name = 'CT_NUMEROLIBERACAOSEGURO';

    [Restrictions([NoValidate])]
    [Column('CT_TOTALMERCADORIASEGURADA', ftBCD, 7077999, 2)]
    [Dictionary('CT_TOTALMERCADORIASEGURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_TOTALMERCADORIASEGURADA: Double read FCT_TOTALMERCADORIASEGURADA write FCT_TOTALMERCADORIASEGURADA;
    const CT_TOTALMERCADORIASEGURADA_Name = 'CT_TOTALMERCADORIASEGURADA';

    [Restrictions([NoValidate])]
    [Column('CT_TIPOCTE', ftString, 1)]
    [Dictionary('CT_TIPOCTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_TIPOCTE: String read FCT_TIPOCTE write FCT_TIPOCTE;
    const CT_TIPOCTE_Name = 'CT_TIPOCTE';

    [Restrictions([NoValidate])]
    [Column('CT_TIPOSERVICO', ftString, 1)]
    [Dictionary('CT_TIPOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_TIPOSERVICO: String read FCT_TIPOSERVICO write FCT_TIPOSERVICO;
    const CT_TIPOSERVICO_Name = 'CT_TIPOSERVICO';

    [Restrictions([NoValidate])]
    [Column('CT_CHAVEACESSOSUBSTITUIDO', ftString, 44)]
    [Dictionary('CT_CHAVEACESSOSUBSTITUIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CHAVEACESSOSUBSTITUIDO: String read FCT_CHAVEACESSOSUBSTITUIDO write FCT_CHAVEACESSOSUBSTITUIDO;
    const CT_CHAVEACESSOSUBSTITUIDO_Name = 'CT_CHAVEACESSOSUBSTITUIDO';

    [Restrictions([NoValidate])]
    [Column('CT_TOMADORCONTRIBUINTEICMS', ftString, 1)]
    [Dictionary('CT_TOMADORCONTRIBUINTEICMS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_TOMADORCONTRIBUINTEICMS: String read FCT_TOMADORCONTRIBUINTEICMS write FCT_TOMADORCONTRIBUINTEICMS;
    const CT_TOMADORCONTRIBUINTEICMS_Name = 'CT_TOMADORCONTRIBUINTEICMS';

    [Restrictions([NoValidate])]
    [Column('CT_CHAVEACESSOTOMADOR', ftString, 44)]
    [Dictionary('CT_CHAVEACESSOTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CHAVEACESSOTOMADOR: String read FCT_CHAVEACESSOTOMADOR write FCT_CHAVEACESSOTOMADOR;
    const CT_CHAVEACESSOTOMADOR_Name = 'CT_CHAVEACESSOTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_CNPJTOMADOR', ftString, 14)]
    [Dictionary('CT_CNPJTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CNPJTOMADOR: String read FCT_CNPJTOMADOR write FCT_CNPJTOMADOR;
    const CT_CNPJTOMADOR_Name = 'CT_CNPJTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_CPFTOMADOR', ftString, 11)]
    [Dictionary('CT_CPFTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CPFTOMADOR: String read FCT_CPFTOMADOR write FCT_CPFTOMADOR;
    const CT_CPFTOMADOR_Name = 'CT_CPFTOMADOR';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOTOMADOR', ftString, 2)]
    [Dictionary('MNF_CODIGOTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOTOMADOR: String read FMNF_CODIGOTOMADOR write FMNF_CODIGOTOMADOR;
    const MNF_CODIGOTOMADOR_Name = 'MNF_CODIGOTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_SERIETOMADOR', ftString, 3)]
    [Dictionary('CT_SERIETOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_SERIETOMADOR: String read FCT_SERIETOMADOR write FCT_SERIETOMADOR;
    const CT_SERIETOMADOR_Name = 'CT_SERIETOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_SUBSERIETOMADOR', ftString, 3)]
    [Dictionary('CT_SUBSERIETOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_SUBSERIETOMADOR: String read FCT_SUBSERIETOMADOR write FCT_SUBSERIETOMADOR;
    const CT_SUBSERIETOMADOR_Name = 'CT_SUBSERIETOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_NOTAFISCALTOMADOR', ftString, 6)]
    [Dictionary('CT_NOTAFISCALTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NOTAFISCALTOMADOR: String read FCT_NOTAFISCALTOMADOR write FCT_NOTAFISCALTOMADOR;
    const CT_NOTAFISCALTOMADOR_Name = 'CT_NOTAFISCALTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_VALORNOTAFISCALTOMADOR', ftBCD, 1952531540, 2)]
    [Dictionary('CT_VALORNOTAFISCALTOMADOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORNOTAFISCALTOMADOR: Double read FCT_VALORNOTAFISCALTOMADOR write FCT_VALORNOTAFISCALTOMADOR;
    const CT_VALORNOTAFISCALTOMADOR_Name = 'CT_VALORNOTAFISCALTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_DATAEMISSAONFTOMADOR', ftDateTime)]
    [Dictionary('CT_DATAEMISSAONFTOMADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property CT_DATAEMISSAONFTOMADOR: TDateTime read FCT_DATAEMISSAONFTOMADOR write FCT_DATAEMISSAONFTOMADOR;
    const CT_DATAEMISSAONFTOMADOR_Name = 'CT_DATAEMISSAONFTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CT_CHAVEACESSOCOMPLEMENTO', ftString, 44)]
    [Dictionary('CT_CHAVEACESSOCOMPLEMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CHAVEACESSOCOMPLEMENTO: String read FCT_CHAVEACESSOCOMPLEMENTO write FCT_CHAVEACESSOCOMPLEMENTO;
    const CT_CHAVEACESSOCOMPLEMENTO_Name = 'CT_CHAVEACESSOCOMPLEMENTO';

    [Restrictions([NoValidate])]
    [Column('CT_CHAVEACESSOANULACAO', ftString, 44)]
    [Dictionary('CT_CHAVEACESSOANULACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CHAVEACESSOANULACAO: String read FCT_CHAVEACESSOANULACAO write FCT_CHAVEACESSOANULACAO;
    const CT_CHAVEACESSOANULACAO_Name = 'CT_CHAVEACESSOANULACAO';

    [Restrictions([NoValidate])]
    [Column('CT_DATAEMISSAODECLARACAO', ftDateTime)]
    [Dictionary('CT_DATAEMISSAODECLARACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CT_DATAEMISSAODECLARACAO: TDateTime read FCT_DATAEMISSAODECLARACAO write FCT_DATAEMISSAODECLARACAO;
    const CT_DATAEMISSAODECLARACAO_Name = 'CT_DATAEMISSAODECLARACAO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftInteger)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEORIGEM: Integer read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CT_CIDADEORIGEM', ftString, 100)]
    [Dictionary('CT_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CIDADEORIGEM: String read FCT_CIDADEORIGEM write FCT_CIDADEORIGEM;
    const CT_CIDADEORIGEM_Name = 'CT_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CT_UFORIGEM', ftString, 2)]
    [Dictionary('CT_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_UFORIGEM: String read FCT_UFORIGEM write FCT_UFORIGEM;
    const CT_UFORIGEM_Name = 'CT_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftInteger)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEDESTINO: Integer read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CT_CIDADEDESTINO', ftString, 100)]
    [Dictionary('CT_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CIDADEDESTINO: String read FCT_CIDADEDESTINO write FCT_CIDADEDESTINO;
    const CT_CIDADEDESTINO_Name = 'CT_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CT_UFDESTINO', ftString, 2)]
    [Dictionary('CT_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_UFDESTINO: String read FCT_UFDESTINO write FCT_UFDESTINO;
    const CT_UFDESTINO_Name = 'CT_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA_01', ftString, 7)]
    [Dictionary('VEI_PLACA_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA_01: String read FVEI_PLACA_01 write FVEI_PLACA_01;
    const VEI_PLACA_01_Name = 'VEI_PLACA_01';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA_02', ftString, 7)]
    [Dictionary('VEI_PLACA_02', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA_02: String read FVEI_PLACA_02 write FVEI_PLACA_02;
    const VEI_PLACA_02_Name = 'VEI_PLACA_02';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA_03', ftString, 7)]
    [Dictionary('VEI_PLACA_03', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA_03: String read FVEI_PLACA_03 write FVEI_PLACA_03;
    const VEI_PLACA_03_Name = 'VEI_PLACA_03';

    [Restrictions([NoValidate])]
    [Column('VEI_CIDADE', ftString, 100)]
    [Dictionary('VEI_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_CIDADE: String read FVEI_CIDADE write FVEI_CIDADE;
    const VEI_CIDADE_Name = 'VEI_CIDADE';

    [Restrictions([NoValidate])]
    [Column('VEI_UF', ftString, 2)]
    [Dictionary('VEI_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_UF: String read FVEI_UF write FVEI_UF;
    const VEI_UF_Name = 'VEI_UF';

    [Restrictions([NoValidate])]
    [Column('VEI_NOMEMARCA', ftString, 30)]
    [Dictionary('VEI_NOMEMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NOMEMARCA: String read FVEI_NOMEMARCA write FVEI_NOMEMARCA;
    const VEI_NOMEMARCA_Name = 'VEI_NOMEMARCA';

    [Restrictions([NoValidate])]
    [Column('PES_TRP', ftInteger)]
    [Dictionary('PES_TRP', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_TRP: Integer read FPES_TRP write FPES_TRP;
    const PES_TRP_Name = 'PES_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_TRP', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_TRP: String read FPES_TIPOPESSOA_TRP write FPES_TIPOPESSOA_TRP;
    const PES_TIPOPESSOA_TRP_Name = 'PES_TIPOPESSOA_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_TRP', ftString, 100)]
    [Dictionary('PES_NOME_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_TRP: String read FPES_NOME_TRP write FPES_NOME_TRP;
    const PES_NOME_TRP_Name = 'PES_NOME_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_TRP', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_TRP: String read FPES_CNPJ_CPF_TRP write FPES_CNPJ_CPF_TRP;
    const PES_CNPJ_CPF_TRP_Name = 'PES_CNPJ_CPF_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_TRP', ftString, 16)]
    [Dictionary('PES_IE_RG_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_TRP: String read FPES_IE_RG_TRP write FPES_IE_RG_TRP;
    const PES_IE_RG_TRP_Name = 'PES_IE_RG_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_HABILITACAO_TRP', ftString, 20)]
    [Dictionary('PES_HABILITACAO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_HABILITACAO_TRP: String read FPES_HABILITACAO_TRP write FPES_HABILITACAO_TRP;
    const PES_HABILITACAO_TRP_Name = 'PES_HABILITACAO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_DATAEMISSAOHABILITACAO_TRP', ftDateTime)]
    [Dictionary('PES_DATAEMISSAOHABILITACAO_TRP', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAEMISSAOHABILITACAO_TRP: TDateTime read FPES_DATAEMISSAOHABILITACAO_TRP write FPES_DATAEMISSAOHABILITACAO_TRP;
    const PES_DATAEMISSAOHABILITACAO_TRP_Name = 'PES_DATAEMISSAOHABILITACAO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_TRP', ftString, 8)]
    [Dictionary('PES_CEP_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_TRP: String read FPES_CEP_TRP write FPES_CEP_TRP;
    const PES_CEP_TRP_Name = 'PES_CEP_TRP';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_TRP', ftString, 7)]
    [Dictionary('CID_IBGE_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_TRP: String read FCID_IBGE_TRP write FCID_IBGE_TRP;
    const CID_IBGE_TRP_Name = 'CID_IBGE_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_TRP', ftString, 100)]
    [Dictionary('PES_CIDADE_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_TRP: String read FPES_CIDADE_TRP write FPES_CIDADE_TRP;
    const PES_CIDADE_TRP_Name = 'PES_CIDADE_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_UF_TRP', ftString, 2)]
    [Dictionary('PES_UF_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_TRP: String read FPES_UF_TRP write FPES_UF_TRP;
    const PES_UF_TRP_Name = 'PES_UF_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_TRP', ftString, 100)]
    [Dictionary('PES_ENDERECO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_TRP: String read FPES_ENDERECO_TRP write FPES_ENDERECO_TRP;
    const PES_ENDERECO_TRP_Name = 'PES_ENDERECO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_TRP', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_TRP: String read FPES_NUMEROENDERECO_TRP write FPES_NUMEROENDERECO_TRP;
    const PES_NUMEROENDERECO_TRP_Name = 'PES_NUMEROENDERECO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_TRP', ftString, 50)]
    [Dictionary('PES_BAIRRO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_TRP: String read FPES_BAIRRO_TRP write FPES_BAIRRO_TRP;
    const PES_BAIRRO_TRP_Name = 'PES_BAIRRO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_TRP', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_TRP: String read FPES_DDD_TELEFONE_1_TRP write FPES_DDD_TELEFONE_1_TRP;
    const PES_DDD_TELEFONE_1_TRP_Name = 'PES_DDD_TELEFONE_1_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_CLIENTEREMETENTE', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_CLIENTEREMETENTE: String read FPES_TIPOPESSOA_CLIENTEREMETENTE write FPES_TIPOPESSOA_CLIENTEREMETENTE;
    const PES_TIPOPESSOA_CLIENTEREMETENTE_Name = 'PES_TIPOPESSOA_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREMETENTE: String read FPES_NOMECLIENTEREMETENTE write FPES_NOMECLIENTEREMETENTE;
    const PES_NOMECLIENTEREMETENTE_Name = 'PES_NOMECLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDOREMETENTE', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDOREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDOREMETENTE: String read FPES_FANTASIA_OU_APELIDOREMETENTE write FPES_FANTASIA_OU_APELIDOREMETENTE;
    const PES_FANTASIA_OU_APELIDOREMETENTE_Name = 'PES_FANTASIA_OU_APELIDOREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTEREMETENTE', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEREMETENTE: String read FPES_CNPJ_CPF_CLIENTEREMETENTE write FPES_CNPJ_CPF_CLIENTEREMETENTE;
    const PES_CNPJ_CPF_CLIENTEREMETENTE_Name = 'PES_CNPJ_CPF_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_CLIENTEREMETENTE', ftString, 16)]
    [Dictionary('PES_IE_RG_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_CLIENTEREMETENTE: String read FPES_IE_RG_CLIENTEREMETENTE write FPES_IE_RG_CLIENTEREMETENTE;
    const PES_IE_RG_CLIENTEREMETENTE_Name = 'PES_IE_RG_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEREMETENTE', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEREMETENTE: String read FPES_CEP_CLIENTEREMETENTE write FPES_CEP_CLIENTEREMETENTE;
    const PES_CEP_CLIENTEREMETENTE_Name = 'PES_CEP_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTEREMETENTE', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTEREMETENTE: String read FCID_IBGE_CLIENTEREMETENTE write FCID_IBGE_CLIENTEREMETENTE;
    const CID_IBGE_CLIENTEREMETENTE_Name = 'CID_IBGE_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEREMETENTE: String read FPES_CIDADE_CLIENTEREMETENTE write FPES_CIDADE_CLIENTEREMETENTE;
    const PES_CIDADE_CLIENTEREMETENTE_Name = 'PES_CIDADE_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEREMETENTE', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEREMETENTE: String read FPES_UF_CLIENTEREMETENTE write FPES_UF_CLIENTEREMETENTE;
    const PES_UF_CLIENTEREMETENTE_Name = 'PES_UF_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS_CLIENTEREMETENTE', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS_CLIENTEREMETENTE: String read FPES_CODIGOPAIS_CLIENTEREMETENTE write FPES_CODIGOPAIS_CLIENTEREMETENTE;
    const PES_CODIGOPAIS_CLIENTEREMETENTE_Name = 'PES_CODIGOPAIS_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS_CLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_PAIS_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS_CLIENTEREMETENTE: String read FPES_PAIS_CLIENTEREMETENTE write FPES_PAIS_CLIENTEREMETENTE;
    const PES_PAIS_CLIENTEREMETENTE_Name = 'PES_PAIS_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEREMETENTE: String read FPES_ENDERECO_CLIENTEREMETENTE write FPES_ENDERECO_CLIENTEREMETENTE;
    const PES_ENDERECO_CLIENTEREMETENTE_Name = 'PES_ENDERECO_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA_CLIENTEREMETENTE', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA_CLIENTEREMETENTE: String read FPES_PONTOREFERENCIA_CLIENTEREMETENTE write FPES_PONTOREFERENCIA_CLIENTEREMETENTE;
    const PES_PONTOREFERENCIA_CLIENTEREMETENTE_Name = 'PES_PONTOREFERENCIA_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_CLIENTEREMETENTE', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_CLIENTEREMETENTE: String read FPES_NUMEROENDERECO_CLIENTEREMETENTE write FPES_NUMEROENDERECO_CLIENTEREMETENTE;
    const PES_NUMEROENDERECO_CLIENTEREMETENTE_Name = 'PES_NUMEROENDERECO_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEREMETENTE', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEREMETENTE: String read FPES_BAIRRO_CLIENTEREMETENTE write FPES_BAIRRO_CLIENTEREMETENTE;
    const PES_BAIRRO_CLIENTEREMETENTE_Name = 'PES_BAIRRO_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTEREMETENTE', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTEREMETENTE: String read FPES_DDD_TELEFONE_1_CLIENTEREMETENTE write FPES_DDD_TELEFONE_1_CLIENTEREMETENTE;
    const PES_DDD_TELEFONE_1_CLIENTEREMETENTE_Name = 'PES_DDD_TELEFONE_1_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCLIENTE_CLIENTEREMETENTE', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE_CLIENTEREMETENTE: String read FPES_TIPOCLIENTE_CLIENTEREMETENTE write FPES_TIPOCLIENTE_CLIENTEREMETENTE;
    const PES_TIPOCLIENTE_CLIENTEREMETENTE_Name = 'PES_TIPOCLIENTE_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_CLIENTEDESTINATARIO', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_CLIENTEDESTINATARIO: String read FPES_TIPOPESSOA_CLIENTEDESTINATARIO write FPES_TIPOPESSOA_CLIENTEDESTINATARIO;
    const PES_TIPOPESSOA_CLIENTEDESTINATARIO_Name = 'PES_TIPOPESSOA_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEDESTINATARIO: String read FPES_NOMECLIENTEDESTINATARIO write FPES_NOMECLIENTEDESTINATARIO;
    const PES_NOMECLIENTEDESTINATARIO_Name = 'PES_NOMECLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTEDESTINATARIO', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEDESTINATARIO: String read FPES_CNPJ_CPF_CLIENTEDESTINATARIO write FPES_CNPJ_CPF_CLIENTEDESTINATARIO;
    const PES_CNPJ_CPF_CLIENTEDESTINATARIO_Name = 'PES_CNPJ_CPF_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_CLIENTEDESTINATARIO', ftString, 16)]
    [Dictionary('PES_IE_RG_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_CLIENTEDESTINATARIO: String read FPES_IE_RG_CLIENTEDESTINATARIO write FPES_IE_RG_CLIENTEDESTINATARIO;
    const PES_IE_RG_CLIENTEDESTINATARIO_Name = 'PES_IE_RG_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEDESTINATARIO', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEDESTINATARIO: String read FPES_CEP_CLIENTEDESTINATARIO write FPES_CEP_CLIENTEDESTINATARIO;
    const PES_CEP_CLIENTEDESTINATARIO_Name = 'PES_CEP_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTEDESTINATARIO', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTEDESTINATARIO: String read FCID_IBGE_CLIENTEDESTINATARIO write FCID_IBGE_CLIENTEDESTINATARIO;
    const CID_IBGE_CLIENTEDESTINATARIO_Name = 'CID_IBGE_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEDESTINATARIO: String read FPES_CIDADE_CLIENTEDESTINATARIO write FPES_CIDADE_CLIENTEDESTINATARIO;
    const PES_CIDADE_CLIENTEDESTINATARIO_Name = 'PES_CIDADE_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEDESTINATARIO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEDESTINATARIO: String read FPES_UF_CLIENTEDESTINATARIO write FPES_UF_CLIENTEDESTINATARIO;
    const PES_UF_CLIENTEDESTINATARIO_Name = 'PES_UF_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS_CLIENTEDESTINATARIO', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS_CLIENTEDESTINATARIO: String read FPES_CODIGOPAIS_CLIENTEDESTINATARIO write FPES_CODIGOPAIS_CLIENTEDESTINATARIO;
    const PES_CODIGOPAIS_CLIENTEDESTINATARIO_Name = 'PES_CODIGOPAIS_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_PAIS_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS_CLIENTEDESTINATARIO: String read FPES_PAIS_CLIENTEDESTINATARIO write FPES_PAIS_CLIENTEDESTINATARIO;
    const PES_PAIS_CLIENTEDESTINATARIO_Name = 'PES_PAIS_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEDESTINATARIO: String read FPES_ENDERECO_CLIENTEDESTINATARIO write FPES_ENDERECO_CLIENTEDESTINATARIO;
    const PES_ENDERECO_CLIENTEDESTINATARIO_Name = 'PES_ENDERECO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA_CLIENTEDESTINATARIO', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA_CLIENTEDESTINATARIO: String read FPES_PONTOREFERENCIA_CLIENTEDESTINATARIO write FPES_PONTOREFERENCIA_CLIENTEDESTINATARIO;
    const PES_PONTOREFERENCIA_CLIENTEDESTINATARIO_Name = 'PES_PONTOREFERENCIA_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_CLIENTEDESTINATARIO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_CLIENTEDESTINATARIO: String read FPES_NUMEROENDERECO_CLIENTEDESTINATARIO write FPES_NUMEROENDERECO_CLIENTEDESTINATARIO;
    const PES_NUMEROENDERECO_CLIENTEDESTINATARIO_Name = 'PES_NUMEROENDERECO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEDESTINATARIO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEDESTINATARIO: String read FPES_BAIRRO_CLIENTEDESTINATARIO write FPES_BAIRRO_CLIENTEDESTINATARIO;
    const PES_BAIRRO_CLIENTEDESTINATARIO_Name = 'PES_BAIRRO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO: String read FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO write FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO;
    const PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO_Name = 'PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCLIENTE_CLIENTEDESTINATARIO', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE_CLIENTEDESTINATARIO: String read FPES_TIPOCLIENTE_CLIENTEDESTINATARIO write FPES_TIPOCLIENTE_CLIENTEDESTINATARIO;
    const PES_TIPOCLIENTE_CLIENTEDESTINATARIO_Name = 'PES_TIPOCLIENTE_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONSIGNATARIO', ftInteger)]
    [Dictionary('PES_CLIENTECONSIGNATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTECONSIGNATARIO: Integer read FPES_CLIENTECONSIGNATARIO write FPES_CLIENTECONSIGNATARIO;
    const PES_CLIENTECONSIGNATARIO_Name = 'PES_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_CLIENTECONSIGNATARIO', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_CLIENTECONSIGNATARIO: String read FPES_TIPOPESSOA_CLIENTECONSIGNATARIO write FPES_TIPOPESSOA_CLIENTECONSIGNATARIO;
    const PES_TIPOPESSOA_CLIENTECONSIGNATARIO_Name = 'PES_TIPOPESSOA_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTECONSIGNATARIO: String read FPES_NOMECLIENTECONSIGNATARIO write FPES_NOMECLIENTECONSIGNATARIO;
    const PES_NOMECLIENTECONSIGNATARIO_Name = 'PES_NOMECLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTECONSIGNATARIO', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTECONSIGNATARIO: String read FPES_CNPJ_CPF_CLIENTECONSIGNATARIO write FPES_CNPJ_CPF_CLIENTECONSIGNATARIO;
    const PES_CNPJ_CPF_CLIENTECONSIGNATARIO_Name = 'PES_CNPJ_CPF_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_CLIENTECONSIGNATARIO', ftString, 16)]
    [Dictionary('PES_IE_RG_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_CLIENTECONSIGNATARIO: String read FPES_IE_RG_CLIENTECONSIGNATARIO write FPES_IE_RG_CLIENTECONSIGNATARIO;
    const PES_IE_RG_CLIENTECONSIGNATARIO_Name = 'PES_IE_RG_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTECONSIGNATARIO', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTECONSIGNATARIO: String read FPES_CEP_CLIENTECONSIGNATARIO write FPES_CEP_CLIENTECONSIGNATARIO;
    const PES_CEP_CLIENTECONSIGNATARIO_Name = 'PES_CEP_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTECONSIGNATARIO', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTECONSIGNATARIO: String read FCID_IBGE_CLIENTECONSIGNATARIO write FCID_IBGE_CLIENTECONSIGNATARIO;
    const CID_IBGE_CLIENTECONSIGNATARIO_Name = 'CID_IBGE_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTECONSIGNATARIO: String read FPES_CIDADE_CLIENTECONSIGNATARIO write FPES_CIDADE_CLIENTECONSIGNATARIO;
    const PES_CIDADE_CLIENTECONSIGNATARIO_Name = 'PES_CIDADE_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTECONSIGNATARIO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTECONSIGNATARIO: String read FPES_UF_CLIENTECONSIGNATARIO write FPES_UF_CLIENTECONSIGNATARIO;
    const PES_UF_CLIENTECONSIGNATARIO_Name = 'PES_UF_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS_CLIENTECONSIGNATARIO', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS_CLIENTECONSIGNATARIO: String read FPES_CODIGOPAIS_CLIENTECONSIGNATARIO write FPES_CODIGOPAIS_CLIENTECONSIGNATARIO;
    const PES_CODIGOPAIS_CLIENTECONSIGNATARIO_Name = 'PES_CODIGOPAIS_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS_CLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_PAIS_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS_CLIENTECONSIGNATARIO: String read FPES_PAIS_CLIENTECONSIGNATARIO write FPES_PAIS_CLIENTECONSIGNATARIO;
    const PES_PAIS_CLIENTECONSIGNATARIO_Name = 'PES_PAIS_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTECONSIGNATARIO: String read FPES_ENDERECO_CLIENTECONSIGNATARIO write FPES_ENDERECO_CLIENTECONSIGNATARIO;
    const PES_ENDERECO_CLIENTECONSIGNATARIO_Name = 'PES_ENDERECO_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_CLIENTECONSIGNATARIO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_CLIENTECONSIGNATARIO: String read FPES_NUMEROENDERECO_CLIENTECONSIGNATARIO write FPES_NUMEROENDERECO_CLIENTECONSIGNATARIO;
    const PES_NUMEROENDERECO_CLIENTECONSIGNATARIO_Name = 'PES_NUMEROENDERECO_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTECONSIGNATARIO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTECONSIGNATARIO: String read FPES_BAIRRO_CLIENTECONSIGNATARIO write FPES_BAIRRO_CLIENTECONSIGNATARIO;
    const PES_BAIRRO_CLIENTECONSIGNATARIO_Name = 'PES_BAIRRO_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO: String read FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO write FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO;
    const PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO_Name = 'PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCLIENTE_CLIENTECONSIGNATARIO', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE_CLIENTECONSIGNATARIO: String read FPES_TIPOCLIENTE_CLIENTECONSIGNATARIO write FPES_TIPOCLIENTE_CLIENTECONSIGNATARIO;
    const PES_TIPOCLIENTE_CLIENTECONSIGNATARIO_Name = 'PES_TIPOCLIENTE_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREDESPACHO', ftInteger)]
    [Dictionary('PES_CLIENTEREDESPACHO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREDESPACHO: Integer read FPES_CLIENTEREDESPACHO write FPES_CLIENTEREDESPACHO;
    const PES_CLIENTEREDESPACHO_Name = 'PES_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_CLIENTEREDESPACHO', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_CLIENTEREDESPACHO: String read FPES_TIPOPESSOA_CLIENTEREDESPACHO write FPES_TIPOPESSOA_CLIENTEREDESPACHO;
    const PES_TIPOPESSOA_CLIENTEREDESPACHO_Name = 'PES_TIPOPESSOA_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREDESPACHO: String read FPES_NOMECLIENTEREDESPACHO write FPES_NOMECLIENTEREDESPACHO;
    const PES_NOMECLIENTEREDESPACHO_Name = 'PES_NOMECLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTEREDESPACHO', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEREDESPACHO: String read FPES_CNPJ_CPF_CLIENTEREDESPACHO write FPES_CNPJ_CPF_CLIENTEREDESPACHO;
    const PES_CNPJ_CPF_CLIENTEREDESPACHO_Name = 'PES_CNPJ_CPF_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_CLIENTEREDESPACHO', ftString, 16)]
    [Dictionary('PES_IE_RG_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_CLIENTEREDESPACHO: String read FPES_IE_RG_CLIENTEREDESPACHO write FPES_IE_RG_CLIENTEREDESPACHO;
    const PES_IE_RG_CLIENTEREDESPACHO_Name = 'PES_IE_RG_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEREDESPACHO', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEREDESPACHO: String read FPES_CEP_CLIENTEREDESPACHO write FPES_CEP_CLIENTEREDESPACHO;
    const PES_CEP_CLIENTEREDESPACHO_Name = 'PES_CEP_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTEREDESPACHO', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTEREDESPACHO: String read FCID_IBGE_CLIENTEREDESPACHO write FCID_IBGE_CLIENTEREDESPACHO;
    const CID_IBGE_CLIENTEREDESPACHO_Name = 'CID_IBGE_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEREDESPACHO: String read FPES_CIDADE_CLIENTEREDESPACHO write FPES_CIDADE_CLIENTEREDESPACHO;
    const PES_CIDADE_CLIENTEREDESPACHO_Name = 'PES_CIDADE_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEREDESPACHO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEREDESPACHO: String read FPES_UF_CLIENTEREDESPACHO write FPES_UF_CLIENTEREDESPACHO;
    const PES_UF_CLIENTEREDESPACHO_Name = 'PES_UF_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS_CLIENTEREDESPACHO', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS_CLIENTEREDESPACHO: String read FPES_CODIGOPAIS_CLIENTEREDESPACHO write FPES_CODIGOPAIS_CLIENTEREDESPACHO;
    const PES_CODIGOPAIS_CLIENTEREDESPACHO_Name = 'PES_CODIGOPAIS_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS_CLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_PAIS_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS_CLIENTEREDESPACHO: String read FPES_PAIS_CLIENTEREDESPACHO write FPES_PAIS_CLIENTEREDESPACHO;
    const PES_PAIS_CLIENTEREDESPACHO_Name = 'PES_PAIS_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEREDESPACHO: String read FPES_ENDERECO_CLIENTEREDESPACHO write FPES_ENDERECO_CLIENTEREDESPACHO;
    const PES_ENDERECO_CLIENTEREDESPACHO_Name = 'PES_ENDERECO_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_CLIENTEREDESPACHO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_CLIENTEREDESPACHO: String read FPES_NUMEROENDERECO_CLIENTEREDESPACHO write FPES_NUMEROENDERECO_CLIENTEREDESPACHO;
    const PES_NUMEROENDERECO_CLIENTEREDESPACHO_Name = 'PES_NUMEROENDERECO_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEREDESPACHO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEREDESPACHO: String read FPES_BAIRRO_CLIENTEREDESPACHO write FPES_BAIRRO_CLIENTEREDESPACHO;
    const PES_BAIRRO_CLIENTEREDESPACHO_Name = 'PES_BAIRRO_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTEREDESPACHO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTEREDESPACHO: String read FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO write FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO;
    const PES_DDD_TELEFONE_1_CLIENTEREDESPACHO_Name = 'PES_DDD_TELEFONE_1_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCLIENTE_CLIENTEREDESPACHO', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE_CLIENTEREDESPACHO: String read FPES_TIPOCLIENTE_CLIENTEREDESPACHO write FPES_TIPOCLIENTE_CLIENTEREDESPACHO;
    const PES_TIPOCLIENTE_CLIENTEREDESPACHO_Name = 'PES_TIPOCLIENTE_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEOUTROS', ftInteger)]
    [Dictionary('PES_CLIENTEOUTROS', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEOUTROS: Integer read FPES_CLIENTEOUTROS write FPES_CLIENTEOUTROS;
    const PES_CLIENTEOUTROS_Name = 'PES_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_CLIENTEOUTROS', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_CLIENTEOUTROS: String read FPES_TIPOPESSOA_CLIENTEOUTROS write FPES_TIPOPESSOA_CLIENTEOUTROS;
    const PES_TIPOPESSOA_CLIENTEOUTROS_Name = 'PES_TIPOPESSOA_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEOUTROS', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEOUTROS: String read FPES_NOMECLIENTEOUTROS write FPES_NOMECLIENTEOUTROS;
    const PES_NOMECLIENTEOUTROS_Name = 'PES_NOMECLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTEOUTROS', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEOUTROS: String read FPES_CNPJ_CPF_CLIENTEOUTROS write FPES_CNPJ_CPF_CLIENTEOUTROS;
    const PES_CNPJ_CPF_CLIENTEOUTROS_Name = 'PES_CNPJ_CPF_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_CLIENTEOUTROS', ftString, 16)]
    [Dictionary('PES_IE_RG_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_CLIENTEOUTROS: String read FPES_IE_RG_CLIENTEOUTROS write FPES_IE_RG_CLIENTEOUTROS;
    const PES_IE_RG_CLIENTEOUTROS_Name = 'PES_IE_RG_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEOUTROS', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEOUTROS: String read FPES_CEP_CLIENTEOUTROS write FPES_CEP_CLIENTEOUTROS;
    const PES_CEP_CLIENTEOUTROS_Name = 'PES_CEP_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTEOUTROS', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTEOUTROS: String read FCID_IBGE_CLIENTEOUTROS write FCID_IBGE_CLIENTEOUTROS;
    const CID_IBGE_CLIENTEOUTROS_Name = 'CID_IBGE_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEOUTROS', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEOUTROS: String read FPES_CIDADE_CLIENTEOUTROS write FPES_CIDADE_CLIENTEOUTROS;
    const PES_CIDADE_CLIENTEOUTROS_Name = 'PES_CIDADE_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEOUTROS', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEOUTROS: String read FPES_UF_CLIENTEOUTROS write FPES_UF_CLIENTEOUTROS;
    const PES_UF_CLIENTEOUTROS_Name = 'PES_UF_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS_CLIENTEOUTROS', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS_CLIENTEOUTROS: String read FPES_CODIGOPAIS_CLIENTEOUTROS write FPES_CODIGOPAIS_CLIENTEOUTROS;
    const PES_CODIGOPAIS_CLIENTEOUTROS_Name = 'PES_CODIGOPAIS_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS_CLIENTEOUTROS', ftString, 100)]
    [Dictionary('PES_PAIS_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS_CLIENTEOUTROS: String read FPES_PAIS_CLIENTEOUTROS write FPES_PAIS_CLIENTEOUTROS;
    const PES_PAIS_CLIENTEOUTROS_Name = 'PES_PAIS_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEOUTROS', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEOUTROS: String read FPES_ENDERECO_CLIENTEOUTROS write FPES_ENDERECO_CLIENTEOUTROS;
    const PES_ENDERECO_CLIENTEOUTROS_Name = 'PES_ENDERECO_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_CLIENTEOUTROS', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_CLIENTEOUTROS: String read FPES_NUMEROENDERECO_CLIENTEOUTROS write FPES_NUMEROENDERECO_CLIENTEOUTROS;
    const PES_NUMEROENDERECO_CLIENTEOUTROS_Name = 'PES_NUMEROENDERECO_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEOUTROS', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEOUTROS: String read FPES_BAIRRO_CLIENTEOUTROS write FPES_BAIRRO_CLIENTEOUTROS;
    const PES_BAIRRO_CLIENTEOUTROS_Name = 'PES_BAIRRO_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTEOUTROS', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTEOUTROS: String read FPES_DDD_TELEFONE_1_CLIENTEOUTROS write FPES_DDD_TELEFONE_1_CLIENTEOUTROS;
    const PES_DDD_TELEFONE_1_CLIENTEOUTROS_Name = 'PES_DDD_TELEFONE_1_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCLIENTE_CLIENTEOUTROS', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE_CLIENTEOUTROS: String read FPES_TIPOCLIENTE_CLIENTEOUTROS write FPES_TIPOCLIENTE_CLIENTEOUTROS;
    const PES_TIPOCLIENTE_CLIENTEOUTROS_Name = 'PES_TIPOCLIENTE_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_PROPRITARIO_VEI', ftInteger)]
    [Dictionary('PES_PROPRITARIO_VEI', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_PROPRITARIO_VEI: Integer read FPES_PROPRITARIO_VEI write FPES_PROPRITARIO_VEI;
    const PES_PROPRITARIO_VEI_Name = 'PES_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_PROPRITARIO_VEI', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_PROPRITARIO_VEI: String read FPES_TIPOPESSOA_PROPRITARIO_VEI write FPES_TIPOPESSOA_PROPRITARIO_VEI;
    const PES_TIPOPESSOA_PROPRITARIO_VEI_Name = 'PES_TIPOPESSOA_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_PROPRITARIO_VEI', ftString, 100)]
    [Dictionary('PES_NOME_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_PROPRITARIO_VEI: String read FPES_NOME_PROPRITARIO_VEI write FPES_NOME_PROPRITARIO_VEI;
    const PES_NOME_PROPRITARIO_VEI_Name = 'PES_NOME_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_PROPRITARIO_VEI', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_PROPRITARIO_VEI: String read FPES_CNPJ_CPF_PROPRITARIO_VEI write FPES_CNPJ_CPF_PROPRITARIO_VEI;
    const PES_CNPJ_CPF_PROPRITARIO_VEI_Name = 'PES_CNPJ_CPF_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_IE_RG_PROPRITARIO_VEI', ftString, 16)]
    [Dictionary('PES_IE_RG_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_PROPRITARIO_VEI: String read FPES_IE_RG_PROPRITARIO_VEI write FPES_IE_RG_PROPRITARIO_VEI;
    const PES_IE_RG_PROPRITARIO_VEI_Name = 'PES_IE_RG_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_PROPRITARIO_VEI', ftString, 8)]
    [Dictionary('PES_CEP_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_PROPRITARIO_VEI: String read FPES_CEP_PROPRITARIO_VEI write FPES_CEP_PROPRITARIO_VEI;
    const PES_CEP_PROPRITARIO_VEI_Name = 'PES_CEP_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_PROPRITARIO_VEI', ftString, 7)]
    [Dictionary('CID_IBGE_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_PROPRITARIO_VEI: String read FCID_IBGE_PROPRITARIO_VEI write FCID_IBGE_PROPRITARIO_VEI;
    const CID_IBGE_PROPRITARIO_VEI_Name = 'CID_IBGE_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_PROPRITARIO_VEI', ftString, 100)]
    [Dictionary('PES_CIDADE_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_PROPRITARIO_VEI: String read FPES_CIDADE_PROPRITARIO_VEI write FPES_CIDADE_PROPRITARIO_VEI;
    const PES_CIDADE_PROPRITARIO_VEI_Name = 'PES_CIDADE_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_UF_PROPRITARIO_VEI', ftString, 2)]
    [Dictionary('PES_UF_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_PROPRITARIO_VEI: String read FPES_UF_PROPRITARIO_VEI write FPES_UF_PROPRITARIO_VEI;
    const PES_UF_PROPRITARIO_VEI_Name = 'PES_UF_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_PROPRITARIO_VEI', ftString, 100)]
    [Dictionary('PES_ENDERECO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_PROPRITARIO_VEI: String read FPES_ENDERECO_PROPRITARIO_VEI write FPES_ENDERECO_PROPRITARIO_VEI;
    const PES_ENDERECO_PROPRITARIO_VEI_Name = 'PES_ENDERECO_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_PROPRITARIO_VEI', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_PROPRITARIO_VEI: String read FPES_NUMEROENDERECO_PROPRITARIO_VEI write FPES_NUMEROENDERECO_PROPRITARIO_VEI;
    const PES_NUMEROENDERECO_PROPRITARIO_VEI_Name = 'PES_NUMEROENDERECO_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_PROPRITARIO_VEI', ftString, 50)]
    [Dictionary('PES_BAIRRO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_PROPRITARIO_VEI: String read FPES_BAIRRO_PROPRITARIO_VEI write FPES_BAIRRO_PROPRITARIO_VEI;
    const PES_BAIRRO_PROPRITARIO_VEI_Name = 'PES_BAIRRO_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_PROPRITARIO_VEI', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_PROPRITARIO_VEI: String read FPES_DDD_TELEFONE_1_PROPRITARIO_VEI write FPES_DDD_TELEFONE_1_PROPRITARIO_VEI;
    const PES_DDD_TELEFONE_1_PROPRITARIO_VEI_Name = 'PES_DDD_TELEFONE_1_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_RNTRC_PROPRITARIO_VEI', ftString, 14)]
    [Dictionary('PES_RNTRC_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_RNTRC_PROPRITARIO_VEI: String read FPES_RNTRC_PROPRITARIO_VEI write FPES_RNTRC_PROPRITARIO_VEI;
    const PES_RNTRC_PROPRITARIO_VEI_Name = 'PES_RNTRC_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_NOME', ftString, 100)]
    [Dictionary('FOR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_NOME: String read FFOR_NOME write FFOR_NOME;
    const FOR_NOME_Name = 'FOR_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_CONHECIMENTOS)

end.
