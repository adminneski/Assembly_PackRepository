unit express.dbo.REL_V01_CTR;

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
  [Table('REL_V01_CTR', '')]
  TDtoREL_V01_CTR = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAENTREGA: TDateTime;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FCTR_NOTAFISCAL: String;
    FFIL_UF_FILIAL: String;
    FFIL_CIDADE_FILIAL: String;
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_NUMERORENAVAM: String;
    FMAR_NOME: String;
    FVEI_PLACA: String;
    FVEI_PLACA_01: String;
    FVEI_PLACA_02: String;
    FVEI_PLACA_03: String;
    FVEI_NOMECIDADE: String;
    FVEI_UFSSIGLA: String;
    FVEI_NOMEMARCA: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FCFOP_DESCRICAO: String;
    FCST_CODIGOCTR: String;
    FCTR_EMITENTE: String;
    FCTR_ESPECIEVOLUMES: String;
    FCTR_NATUREZA: String;
    FCTR_NATUREZACARGA: String;
    FCTR_NUMERODOCTO: String;
    FCTR_COBRADORA: String;
    FCTR_SEGURADORA: String;
    FCTR_APOLICE: String;
    FCTR_TIPOFRETE: String;
    FCTR_TOTALFRETE: Double;
    FCTR_TOTALICMS: Double;
    FCTR_TOTALSEGURO: Double;
    FCTR_TOTALPEDAGIO: Double;
    FCTR_TOTALDESPACHO: Double;
    FCTR_PERCENTUALICMS: Double;
    FCTR_VALORQUILOFRETE: Double;
    FCTR_PERCENTUALFRETE: Double;
    FCTR_TOTALPRESTACAO: Double;
    FCTR_TOTALNOTAFISCAL: Double;
    FCTR_TOTALPESOLIQUIDO: Double;
    FCTR_TOTALNUMEROVOLUMES: Double;
    FCTR_TOTALBASECALCULOICMS: Double;
    FCTR_TOTALOUTRASDESPESAS: Double;
    FCTR_TOTALMERCADORIASEGURADA: Double;
    FCTR_NUMEROLIBERACAOSEGURO: String;
    FCTR_SERIELIBERACAOSEGURO: String;
    FCTR_PROCESSADO: String;
    FCTR_OBSERVACAO: String;
    FCTR_LIVROFISCAL: String;
    FCTR_CANCELADO: String;
    FCTR_DATAALTERACAO: TDateTime;
    FCTR_DATACANCELAMENTO: TDateTime;
    FCTR_OBSERVACAOCANCELAMENTO: String;
    FCTR_TOTALBCALCULOPISCOFINS: Double;
    FCTR_TOTALPIS: Double;
    FCTR_TOTALCOFINS: Double;
    FCTR_PERCENTUALPIS: Double;
    FCTR_PERCENTUALCOFINS: Double;
    FCSTPC_CODIGO: String;
    FCTR_TOTALSEC_CAT: Double;
    FCTR_PERCENTUALDESCONTO: Double;
    FCTR_TOTALDESCONTO: Double;
    FPES_TRP: Integer;
    FPES_TIPOPESSOA_TRP: String;
    FPES_NOME_TRP: String;
    FPES_CNPJ_CPF_TRP: String;
    FPES_IE_CI_TRP: String;
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
    FPES_PROPRITARIO_VEI: Integer;
    FPES_TIPOPESSOA_PROPRITARIO_VEI: String;
    FPES_NOME_PROPRITARIO_VEI: String;
    FPES_CNPJ_CPF_PROPRITARIO_VEI: String;
    FPES_IE_CI_PROPRITARIO_VEI: String;
    FPES_CEP_PROPRITARIO_VEI: String;
    FCID_IBGE_PROPRITARIO_VEI: String;
    FPES_CIDADE_PROPRITARIO_VEI: String;
    FPES_UF_PROPRITARIO_VEI: String;
    FPES_ENDERECO_PROPRITARIO_VEI: String;
    FPES_NUMEROENDERECO_PROPRITARIO_VEI: String;
    FPES_BAIRRO_PROPRITARIO_VEI: String;
    FPES_DDD_TELEFONE_1_PROPRITARIO_VEI: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_TIPOPESSOA_CLIENTEREMETENTE: String;
    FPES_NOMECLIENTEREMETENTE: String;
    FPES_CNPJ_CPF_CLIENTEREMETENTE: String;
    FPES_IE_CI_CLIENTEREMETENTE: String;
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
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_TIPOPESSOA_CLIENTEDESTINATARIO: String;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_CNPJ_CPF_CLIENTEDESTINATARIO: String;
    FPES_IE_CI_CLIENTEDESTINATARIO: String;
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
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_TIPOPESSOA_CLIENTECONSIGNATARIO: String;
    FPES_NOMECLIENTECONSIGNATARIO: String;
    FPES_CNPJ_CPF_CLIENTECONSIGNATARIO: String;
    FPES_IE_CI_CLIENTECONSIGNATARIO: String;
    FPES_CEP_CLIENTECONSIGNATARIO: String;
    FCID_IBGE_CLIENTECONSIGNATARIO: String;
    FPES_CIDADE_CLIENTECONSIGNATARIO: String;
    FPES_UF_CLIENTECONSIGNATARIO: String;
    FPES_ENDERECO_CLIENTECONSIGNATARIO: String;
    FPES_NUMEROENDERECO_CLIENTECONSIGNATARIO: String;
    FPES_BAIRRO_CLIENTECONSIGNATARIO: String;
    FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO: String;
    FPES_CLIENTEREDESPACHO: Integer;
    FPES_TIPOPESSOA_CLIENTEREDESPACHO: String;
    FPES_NOMECLIENTEREDESPACHO: String;
    FPES_CNPJ_CPF_CLIENTEREDESPACHO: String;
    FPES_IE_CI_CLIENTEREDESPACHO: String;
    FPES_CEP_CLIENTEREDESPACHO: String;
    FCID_IBGE_CLIENTEREDESPACHO: String;
    FPES_CIDADE_CLIENTEREDESPACHO: String;
    FPES_UF_CLIENTEREDESPACHO: String;
    FPES_ENDERECO_CLIENTEREDESPACHO: String;
    FPES_NUMEROENDERECO_CLIENTEREDESPACHO: String;
    FPES_BAIRRO_CLIENTEREDESPACHO: String;
    FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO: String;
    FPES_CLIENTEOUTROS: Integer;
    FPES_TIPOPESSOA_CLIENTEOUTROS: String;
    FPES_NOMECLIENTEOUTROS: String;
    FPES_CNPJ_CPF_CLIENTEOUTROS: String;
    FPES_IE_CI_CLIENTEOUTROS: String;
    FFOR_CODIGO: Integer;
    FFOR_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAENTREGA', ftDateTime)]
    [Dictionary('CTR_DATAENTREGA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAENTREGA: TDateTime read FCTR_DATAENTREGA write FCTR_DATAENTREGA;
    const CTR_DATAENTREGA_Name = 'CTR_DATAENTREGA';

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
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FIL_UF_FILIAL', ftString, 2)]
    [Dictionary('FIL_UF_FILIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FIL_UF_FILIAL: String read FFIL_UF_FILIAL write FFIL_UF_FILIAL;
    const FIL_UF_FILIAL_Name = 'FIL_UF_FILIAL';

    [Restrictions([NoValidate])]
    [Column('FIL_CIDADE_FILIAL', ftString, 100)]
    [Dictionary('FIL_CIDADE_FILIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FIL_CIDADE_FILIAL: String read FFIL_CIDADE_FILIAL write FFIL_CIDADE_FILIAL;
    const FIL_CIDADE_FILIAL_Name = 'FIL_CIDADE_FILIAL';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMERORENAVAM', ftString, 15)]
    [Dictionary('VEI_NUMERORENAVAM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMERORENAVAM: String read FVEI_NUMERORENAVAM write FVEI_NUMERORENAVAM;
    const VEI_NUMERORENAVAM_Name = 'VEI_NUMERORENAVAM';

    [Restrictions([NoValidate])]
    [Column('MAR_NOME', ftString, 30)]
    [Dictionary('MAR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOME: String read FMAR_NOME write FMAR_NOME;
    const MAR_NOME_Name = 'MAR_NOME';

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
    [Column('VEI_NOMECIDADE', ftString, 100)]
    [Dictionary('VEI_NOMECIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NOMECIDADE: String read FVEI_NOMECIDADE write FVEI_NOMECIDADE;
    const VEI_NOMECIDADE_Name = 'VEI_NOMECIDADE';

    [Restrictions([NoValidate])]
    [Column('VEI_UFSSIGLA', ftString, 2)]
    [Dictionary('VEI_UFSSIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_UFSSIGLA: String read FVEI_UFSSIGLA write FVEI_UFSSIGLA;
    const VEI_UFSSIGLA_Name = 'VEI_UFSSIGLA';

    [Restrictions([NoValidate])]
    [Column('VEI_NOMEMARCA', ftString, 30)]
    [Dictionary('VEI_NOMEMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NOMEMARCA: String read FVEI_NOMEMARCA write FVEI_NOMEMARCA;
    const VEI_NOMEMARCA_Name = 'VEI_NOMEMARCA';

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
    [Column('CFOP_DESCRICAO', ftString, 300)]
    [Dictionary('CFOP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_DESCRICAO: String read FCFOP_DESCRICAO write FCFOP_DESCRICAO;
    const CFOP_DESCRICAO_Name = 'CFOP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOCTR', ftString, 2)]
    [Dictionary('CST_CODIGOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOCTR: String read FCST_CODIGOCTR write FCST_CODIGOCTR;
    const CST_CODIGOCTR_Name = 'CST_CODIGOCTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_EMITENTE', ftString, 1)]
    [Dictionary('CTR_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMITENTE: String read FCTR_EMITENTE write FCTR_EMITENTE;
    const CTR_EMITENTE_Name = 'CTR_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTR_ESPECIEVOLUMES', ftString, 15)]
    [Dictionary('CTR_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ESPECIEVOLUMES: String read FCTR_ESPECIEVOLUMES write FCTR_ESPECIEVOLUMES;
    const CTR_ESPECIEVOLUMES_Name = 'CTR_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZA', ftString, 20)]
    [Dictionary('CTR_NATUREZA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZA: String read FCTR_NATUREZA write FCTR_NATUREZA;
    const CTR_NATUREZA_Name = 'CTR_NATUREZA';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZACARGA', ftString, 15)]
    [Dictionary('CTR_NATUREZACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZACARGA: String read FCTR_NATUREZACARGA write FCTR_NATUREZACARGA;
    const CTR_NATUREZACARGA_Name = 'CTR_NATUREZACARGA';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_COBRADORA', ftString, 15)]
    [Dictionary('CTR_COBRADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_COBRADORA: String read FCTR_COBRADORA write FCTR_COBRADORA;
    const CTR_COBRADORA_Name = 'CTR_COBRADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_SEGURADORA', ftString, 25)]
    [Dictionary('CTR_SEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SEGURADORA: String read FCTR_SEGURADORA write FCTR_SEGURADORA;
    const CTR_SEGURADORA_Name = 'CTR_SEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_APOLICE', ftString, 20)]
    [Dictionary('CTR_APOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_APOLICE: String read FCTR_APOLICE write FCTR_APOLICE;
    const CTR_APOLICE_Name = 'CTR_APOLICE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TIPOFRETE', ftString, 1)]
    [Dictionary('CTR_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOFRETE: String read FCTR_TIPOFRETE write FCTR_TIPOFRETE;
    const CTR_TIPOFRETE_Name = 'CTR_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALFRETE', ftBCD)]
    [Dictionary('CTR_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALFRETE: Double read FCTR_TOTALFRETE write FCTR_TOTALFRETE;
    const CTR_TOTALFRETE_Name = 'CTR_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALICMS', ftBCD)]
    [Dictionary('CTR_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALICMS: Double read FCTR_TOTALICMS write FCTR_TOTALICMS;
    const CTR_TOTALICMS_Name = 'CTR_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALSEGURO', ftBCD)]
    [Dictionary('CTR_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALSEGURO: Double read FCTR_TOTALSEGURO write FCTR_TOTALSEGURO;
    const CTR_TOTALSEGURO_Name = 'CTR_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPEDAGIO', ftBCD)]
    [Dictionary('CTR_TOTALPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPEDAGIO: Double read FCTR_TOTALPEDAGIO write FCTR_TOTALPEDAGIO;
    const CTR_TOTALPEDAGIO_Name = 'CTR_TOTALPEDAGIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALDESPACHO', ftBCD, 16387, 2)]
    [Dictionary('CTR_TOTALDESPACHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALDESPACHO: Double read FCTR_TOTALDESPACHO write FCTR_TOTALDESPACHO;
    const CTR_TOTALDESPACHO_Name = 'CTR_TOTALDESPACHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PERCENTUALICMS', ftBCD, 1329815375, 2)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORQUILOFRETE', ftBCD, 1229213507, 3)]
    [Dictionary('CTR_VALORQUILOFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORQUILOFRETE: Double read FCTR_VALORQUILOFRETE write FCTR_VALORQUILOFRETE;
    const CTR_VALORQUILOFRETE_Name = 'CTR_VALORQUILOFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALFRETE', ftBCD, 16385, 2)]
    [Dictionary('CTR_PERCENTUALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALFRETE: Double read FCTR_PERCENTUALFRETE write FCTR_PERCENTUALFRETE;
    const CTR_PERCENTUALFRETE_Name = 'CTR_PERCENTUALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPRESTACAO', ftBCD, 1, 2)]
    [Dictionary('CTR_TOTALPRESTACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPRESTACAO: Double read FCTR_TOTALPRESTACAO write FCTR_TOTALPRESTACAO;
    const CTR_TOTALPRESTACAO_Name = 'CTR_TOTALPRESTACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNOTAFISCAL: Double read FCTR_TOTALNOTAFISCAL write FCTR_TOTALNOTAFISCAL;
    const CTR_TOTALNOTAFISCAL_Name = 'CTR_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPESOLIQUIDO: Double read FCTR_TOTALPESOLIQUIDO write FCTR_TOTALPESOLIQUIDO;
    const CTR_TOTALPESOLIQUIDO_Name = 'CTR_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALNUMEROVOLUMES', ftBCD, 52, 3)]
    [Dictionary('CTR_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNUMEROVOLUMES: Double read FCTR_TOTALNUMEROVOLUMES write FCTR_TOTALNUMEROVOLUMES;
    const CTR_TOTALNUMEROVOLUMES_Name = 'CTR_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('CTR_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBASECALCULOICMS: Double read FCTR_TOTALBASECALCULOICMS write FCTR_TOTALBASECALCULOICMS;
    const CTR_TOTALBASECALCULOICMS_Name = 'CTR_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALOUTRASDESPESAS', ftBCD, 2097184, 2)]
    [Dictionary('CTR_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALOUTRASDESPESAS: Double read FCTR_TOTALOUTRASDESPESAS write FCTR_TOTALOUTRASDESPESAS;
    const CTR_TOTALOUTRASDESPESAS_Name = 'CTR_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALMERCADORIASEGURADA', ftBCD, 5177428, 2)]
    [Dictionary('CTR_TOTALMERCADORIASEGURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALMERCADORIASEGURADA: Double read FCTR_TOTALMERCADORIASEGURADA write FCTR_TOTALMERCADORIASEGURADA;
    const CTR_TOTALMERCADORIASEGURADA_Name = 'CTR_TOTALMERCADORIASEGURADA';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROLIBERACAOSEGURO', ftString, 20)]
    [Dictionary('CTR_NUMEROLIBERACAOSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROLIBERACAOSEGURO: String read FCTR_NUMEROLIBERACAOSEGURO write FCTR_NUMEROLIBERACAOSEGURO;
    const CTR_NUMEROLIBERACAOSEGURO_Name = 'CTR_NUMEROLIBERACAOSEGURO';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIELIBERACAOSEGURO', ftString, 2)]
    [Dictionary('CTR_SERIELIBERACAOSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIELIBERACAOSEGURO: String read FCTR_SERIELIBERACAOSEGURO write FCTR_SERIELIBERACAOSEGURO;
    const CTR_SERIELIBERACAOSEGURO_Name = 'CTR_SERIELIBERACAOSEGURO';

    [Restrictions([NoValidate])]
    [Column('CTR_PROCESSADO', ftString, 1)]
    [Dictionary('CTR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROCESSADO: String read FCTR_PROCESSADO write FCTR_PROCESSADO;
    const CTR_PROCESSADO_Name = 'CTR_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO: String read FCTR_OBSERVACAO write FCTR_OBSERVACAO;
    const CTR_OBSERVACAO_Name = 'CTR_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_LIVROFISCAL', ftString, 1)]
    [Dictionary('CTR_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_LIVROFISCAL: String read FCTR_LIVROFISCAL write FCTR_LIVROFISCAL;
    const CTR_LIVROFISCAL_Name = 'CTR_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_CANCELADO', ftString, 1)]
    [Dictionary('CTR_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CANCELADO: String read FCTR_CANCELADO write FCTR_CANCELADO;
    const CTR_CANCELADO_Name = 'CTR_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAALTERACAO: TDateTime read FCTR_DATAALTERACAO write FCTR_DATAALTERACAO;
    const CTR_DATAALTERACAO_Name = 'CTR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('CTR_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATACANCELAMENTO: TDateTime read FCTR_DATACANCELAMENTO write FCTR_DATACANCELAMENTO;
    const CTR_DATACANCELAMENTO_Name = 'CTR_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_OBSERVACAOCANCELAMENTO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAOCANCELAMENTO: String read FCTR_OBSERVACAOCANCELAMENTO write FCTR_OBSERVACAOCANCELAMENTO;
    const CTR_OBSERVACAOCANCELAMENTO_Name = 'CTR_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALBCALCULOPISCOFINS', ftBCD, 7274610, 2)]
    [Dictionary('CTR_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBCALCULOPISCOFINS: Double read FCTR_TOTALBCALCULOPISCOFINS write FCTR_TOTALBCALCULOPISCOFINS;
    const CTR_TOTALBCALCULOPISCOFINS_Name = 'CTR_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPIS', ftBCD, 5374017, 2)]
    [Dictionary('CTR_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPIS: Double read FCTR_TOTALPIS write FCTR_TOTALPIS;
    const CTR_TOTALPIS_Name = 'CTR_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALCOFINS', ftBCD, 4522067, 2)]
    [Dictionary('CTR_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALCOFINS: Double read FCTR_TOTALCOFINS write FCTR_TOTALCOFINS;
    const CTR_TOTALCOFINS_Name = 'CTR_TOTALCOFINS';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALPIS', ftBCD, 538970637, 2)]
    [Dictionary('CTR_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALPIS: Double read FCTR_PERCENTUALPIS write FCTR_PERCENTUALPIS;
    const CTR_PERCENTUALPIS_Name = 'CTR_PERCENTUALPIS';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALCOFINS', ftBCD, 1953391939, 2)]
    [Dictionary('CTR_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALCOFINS: Double read FCTR_PERCENTUALCOFINS write FCTR_PERCENTUALCOFINS;
    const CTR_PERCENTUALCOFINS_Name = 'CTR_PERCENTUALCOFINS';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALSEC_CAT', ftBCD, 4784197, 2)]
    [Dictionary('CTR_TOTALSEC_CAT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALSEC_CAT: Double read FCTR_TOTALSEC_CAT write FCTR_TOTALSEC_CAT;
    const CTR_TOTALSEC_CAT_Name = 'CTR_TOTALSEC_CAT';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALDESCONTO', ftBCD, 4587552, 2)]
    [Dictionary('CTR_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALDESCONTO: Double read FCTR_PERCENTUALDESCONTO write FCTR_PERCENTUALDESCONTO;
    const CTR_PERCENTUALDESCONTO_Name = 'CTR_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALDESCONTO', ftBCD, 2097196, 2)]
    [Dictionary('CTR_TOTALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALDESCONTO: Double read FCTR_TOTALDESCONTO write FCTR_TOTALDESCONTO;
    const CTR_TOTALDESCONTO_Name = 'CTR_TOTALDESCONTO';

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
    [Column('PES_IE_CI_TRP', ftString, 16)]
    [Dictionary('PES_IE_CI_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_TRP: String read FPES_IE_CI_TRP write FPES_IE_CI_TRP;
    const PES_IE_CI_TRP_Name = 'PES_IE_CI_TRP';

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
    [Column('PES_IE_CI_PROPRITARIO_VEI', ftString, 16)]
    [Dictionary('PES_IE_CI_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_PROPRITARIO_VEI: String read FPES_IE_CI_PROPRITARIO_VEI write FPES_IE_CI_PROPRITARIO_VEI;
    const PES_IE_CI_PROPRITARIO_VEI_Name = 'PES_IE_CI_PROPRITARIO_VEI';

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
    [Column('PES_CNPJ_CPF_CLIENTEREMETENTE', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEREMETENTE: String read FPES_CNPJ_CPF_CLIENTEREMETENTE write FPES_CNPJ_CPF_CLIENTEREMETENTE;
    const PES_CNPJ_CPF_CLIENTEREMETENTE_Name = 'PES_CNPJ_CPF_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_CLIENTEREMETENTE', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTEREMETENTE: String read FPES_IE_CI_CLIENTEREMETENTE write FPES_IE_CI_CLIENTEREMETENTE;
    const PES_IE_CI_CLIENTEREMETENTE_Name = 'PES_IE_CI_CLIENTEREMETENTE';

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
    [Column('PES_IE_CI_CLIENTEDESTINATARIO', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTEDESTINATARIO: String read FPES_IE_CI_CLIENTEDESTINATARIO write FPES_IE_CI_CLIENTEDESTINATARIO;
    const PES_IE_CI_CLIENTEDESTINATARIO_Name = 'PES_IE_CI_CLIENTEDESTINATARIO';

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
    [Column('PES_IE_CI_CLIENTECONSIGNATARIO', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTECONSIGNATARIO: String read FPES_IE_CI_CLIENTECONSIGNATARIO write FPES_IE_CI_CLIENTECONSIGNATARIO;
    const PES_IE_CI_CLIENTECONSIGNATARIO_Name = 'PES_IE_CI_CLIENTECONSIGNATARIO';

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
    [Column('PES_IE_CI_CLIENTEREDESPACHO', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTEREDESPACHO: String read FPES_IE_CI_CLIENTEREDESPACHO write FPES_IE_CI_CLIENTEREDESPACHO;
    const PES_IE_CI_CLIENTEREDESPACHO_Name = 'PES_IE_CI_CLIENTEREDESPACHO';

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
    [Column('PES_IE_CI_CLIENTEOUTROS', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTEOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTEOUTROS: String read FPES_IE_CI_CLIENTEOUTROS write FPES_IE_CI_CLIENTEOUTROS;
    const PES_IE_CI_CLIENTEOUTROS_Name = 'PES_IE_CI_CLIENTEOUTROS';

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
  TRegisterClass.RegisterEntity(TDtoREL_V01_CTR)

end.
