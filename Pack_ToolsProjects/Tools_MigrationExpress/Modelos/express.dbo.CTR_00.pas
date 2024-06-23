unit express.dbo.CTR_00;

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
  [Table('CTR_00', '')]
  [PrimaryKey('CTR_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTR_ID')]
  TDtoCTR_00 = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAENTREGA: TDateTime;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FMNF_CODIGO: String;
    FCTR_NOTAFISCAL: String;
    FVEI_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FLEF_CODIGO: Integer;
    FCSTPC_CODIGO: String;
    FCTR_EMITENTE: String;
    FCTR_ESPECIEVOLUMES: String;
    FCTR_NATUREZA: String;
    FCTR_NATUREZACARGA: String;
    FCTR_NUMERODOCTO: String;
    FPES_CLIENTEOUTROS: Integer;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_CLIENTEREDESPACHO: Integer;
    FFOR_CODIGO: Integer;
    FNTO_CODIGO: Integer;
    FCTR_TIPOCTE: String;
    FCTR_TIPOFRETE: String;
    FCTR_TIPOSERVICO: String;
    FCTR_TOTALFRETE: Double;
    FCTR_TOTALICMS: Double;
    FCTR_TOTALSEGURO: Double;
    FCTR_TOTALPEDAGIO: Double;
    FCTR_TOTALDESPACHO: Double;
    FCTR_TOTALPRESTACAO: Double;
    FCTR_TOTALNOTAFISCAL: Double;
    FCTR_TOTALPESOLIQUIDO: Double;
    FCTR_TOTALNUMEROVOLUMES: Double;
    FCTR_TOTALBASECALCULOICMS: Double;
    FCTR_TOTALOUTRASDESPESAS: Double;
    FCTR_TOTALMERCADORIASEGURADA: Double;
    FCTR_NUMEROLIBERACAOSEGURO: String;
    FCTR_SERIELIBERACAOSEGURO: String;
    FCTR_TOTALBCALCULOPISCOFINS: Double;
    FCTR_TOTALDESCONTO: Double;
    FCTR_TOTALPIS: Double;
    FCTR_TOTALCOFINS: Double;
    FCTR_TOTALPRODUTOS: Double;
    FCTR_PLACAVEICULO: String;
    FCTR_PERCENTUALICMS: Double;
    FCTR_PERCENTUALDESCONTO: Double;
    FCTR_PERCENTUALCOFINS: Double;
    FCTR_UFVEICULO: String;
    FCTR_COBRADORA: String;
    FCTR_SEGURADORA: String;
    FCTR_APOLICE: String;
    FCTR_PERCENTUALFRETE: Double;
    FCTR_VALORQUILOFRETE: Double;
    FCTR_TOTALSEC_CAT: Double;
    FCTR_PERCENTUALPIS: Double;
    FCTR_NUMEROCIOT: String;
    FCST_CODIGOCTR: String;
    FCTR_TOTALPESOBRUTO: Double;
    FCTR_TOTALAPROXIMADOIMPOSTO: Double;
    FCTR_TOTALIBPTESTADUAL: Double;
    FCTR_TOTALIBPTNACIONAL: Double;
    FCTR_PERCENTUALIBPT: Double;
    FCTR_PERCENTUALIBPTESTADUAL: Double;
    FCTR_PERCENTUALIBPTNACIONAL: Double;
    FCTR_CNPJTOMADOR: String;
    FCTR_CPFTOMADOR: String;
    FMNF_CODIGOTOMADOR: String;
    FCTR_SERIETOMADOR: String;
    FCTR_SUBSERIETOMADOR: String;
    FCTR_NOTAFISCALTOMADOR: String;
    FCTR_VALORNOTAFISCALTOMADOR: Double;
    FCTR_DATAEMISSAONFTOMADOR: TDateTime;
    FCTR_TOMADORCONTRIBUINTEICMS: String;
    FCTR_CHAVEACESSOTOMADOR: String;
    FCTR_CHAVEACESSOSUBSTITUIDO: String;
    FCTR_CHAVEACESSOCOMPLEMENTO: String;
    FCTR_CHAVEACESSOANULACAO: String;
    FCTR_DATAEMISSAODECLARACAO: TDateTime;
    FCID_IBGEORIGEM: Integer;
    FCTR_CIDADEORIGEM: String;
    FCTR_UFORIGEM: String;
    FCID_IBGEDESTINO: Integer;
    FCTR_CIDADEDESTINO: String;
    FCTR_UFDESTINO: String;
    FLIB_NUMEROLIBERACAO: String;
    FCTR_DATACANCELAMENTO: TDateTime;
    FCTR_OBSERVACAOCANCELAMENTO: String;
    FCTR_OBSERVACAO: String;
    FCTR_CANCELADO: String;
    FCTR_LIVROFISCAL: String;
    FCTR_PROCESSADO: String;
    FCTR_DATAALTERACAO: TDateTime;
    FLIB_ID: Integer;
    FCTR_AVERBADO: String;
    FCTR_NOMESEGURADORA: String;
    FCTR_CNPJSEGURADORA: String;
    FCTR_NUMEROAPOLICE: String;
    FCTR_NUMEROAVERBACAO: String;
    FCTR_DATAAVERBACAO: TDateTime;
    FCTR_HORAAVERBACAO: String;
    FCTR_PROTOCOLOAVERBACAO: String;
    FCTR_QUANTIDADECARGA: Double;
    FCTR_UNIDADEMENIDACARGA: String;
    FCTR_ID_OLD: Integer;
    FLIB_ID_OLD: Integer;
    FCTR_UNIDADEMEDIDACARGA: String;
  public 
    { Public declarations } 
     const Table      = 'CTR_00';
     const PrimaryKey = 'CTR_ID';
     const Sequence   = 'SEQ_CTR_ID';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

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
    [Column('PES_CLIENTEOUTROS', ftInteger)]
    [Dictionary('PES_CLIENTEOUTROS', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEOUTROS: Integer read FPES_CLIENTEOUTROS write FPES_CLIENTEOUTROS;
    const PES_CLIENTEOUTROS_Name = 'PES_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONSIGNATARIO', ftInteger)]
    [Dictionary('PES_CLIENTECONSIGNATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTECONSIGNATARIO: Integer read FPES_CLIENTECONSIGNATARIO write FPES_CLIENTECONSIGNATARIO;
    const PES_CLIENTECONSIGNATARIO_Name = 'PES_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREDESPACHO', ftInteger)]
    [Dictionary('PES_CLIENTEREDESPACHO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREDESPACHO: Integer read FPES_CLIENTEREDESPACHO write FPES_CLIENTEREDESPACHO;
    const PES_CLIENTEREDESPACHO_Name = 'PES_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOCTE', ftString, 1)]
    [Dictionary('CTR_TIPOCTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOCTE: String read FCTR_TIPOCTE write FCTR_TIPOCTE;
    const CTR_TIPOCTE_Name = 'CTR_TIPOCTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TIPOFRETE', ftString, 1)]
    [Dictionary('CTR_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOFRETE: String read FCTR_TIPOFRETE write FCTR_TIPOFRETE;
    const CTR_TIPOFRETE_Name = 'CTR_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOSERVICO', ftString, 1)]
    [Dictionary('CTR_TIPOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOSERVICO: String read FCTR_TIPOSERVICO write FCTR_TIPOSERVICO;
    const CTR_TIPOSERVICO_Name = 'CTR_TIPOSERVICO';

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
    [Column('CTR_TOTALDESPACHO', ftBCD)]
    [Dictionary('CTR_TOTALDESPACHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALDESPACHO: Double read FCTR_TOTALDESPACHO write FCTR_TOTALDESPACHO;
    const CTR_TOTALDESPACHO_Name = 'CTR_TOTALDESPACHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPRESTACAO', ftBCD)]
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
    [Column('CTR_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNUMEROVOLUMES: Double read FCTR_TOTALNUMEROVOLUMES write FCTR_TOTALNUMEROVOLUMES;
    const CTR_TOTALNUMEROVOLUMES_Name = 'CTR_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('CTR_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBASECALCULOICMS: Double read FCTR_TOTALBASECALCULOICMS write FCTR_TOTALBASECALCULOICMS;
    const CTR_TOTALBASECALCULOICMS_Name = 'CTR_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CTR_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALOUTRASDESPESAS: Double read FCTR_TOTALOUTRASDESPESAS write FCTR_TOTALOUTRASDESPESAS;
    const CTR_TOTALOUTRASDESPESAS_Name = 'CTR_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALMERCADORIASEGURADA', ftBCD)]
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
    [Column('CTR_TOTALBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('CTR_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBCALCULOPISCOFINS: Double read FCTR_TOTALBCALCULOPISCOFINS write FCTR_TOTALBCALCULOPISCOFINS;
    const CTR_TOTALBCALCULOPISCOFINS_Name = 'CTR_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALDESCONTO', ftBCD)]
    [Dictionary('CTR_TOTALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALDESCONTO: Double read FCTR_TOTALDESCONTO write FCTR_TOTALDESCONTO;
    const CTR_TOTALDESCONTO_Name = 'CTR_TOTALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPIS', ftBCD)]
    [Dictionary('CTR_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPIS: Double read FCTR_TOTALPIS write FCTR_TOTALPIS;
    const CTR_TOTALPIS_Name = 'CTR_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALCOFINS', ftBCD)]
    [Dictionary('CTR_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALCOFINS: Double read FCTR_TOTALCOFINS write FCTR_TOTALCOFINS;
    const CTR_TOTALCOFINS_Name = 'CTR_TOTALCOFINS';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPRODUTOS', ftBCD)]
    [Dictionary('CTR_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPRODUTOS: Double read FCTR_TOTALPRODUTOS write FCTR_TOTALPRODUTOS;
    const CTR_TOTALPRODUTOS_Name = 'CTR_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('CTR_PLACAVEICULO', ftString, 7)]
    [Dictionary('CTR_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PLACAVEICULO: String read FCTR_PLACAVEICULO write FCTR_PLACAVEICULO;
    const CTR_PLACAVEICULO_Name = 'CTR_PLACAVEICULO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PERCENTUALICMS', ftBCD)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('CTR_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALDESCONTO: Double read FCTR_PERCENTUALDESCONTO write FCTR_PERCENTUALDESCONTO;
    const CTR_PERCENTUALDESCONTO_Name = 'CTR_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('CTR_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALCOFINS: Double read FCTR_PERCENTUALCOFINS write FCTR_PERCENTUALCOFINS;
    const CTR_PERCENTUALCOFINS_Name = 'CTR_PERCENTUALCOFINS';

    [Restrictions([NoValidate])]
    [Column('CTR_UFVEICULO', ftString, 2)]
    [Dictionary('CTR_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UFVEICULO: String read FCTR_UFVEICULO write FCTR_UFVEICULO;
    const CTR_UFVEICULO_Name = 'CTR_UFVEICULO';

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

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALFRETE', ftBCD)]
    [Dictionary('CTR_PERCENTUALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALFRETE: Double read FCTR_PERCENTUALFRETE write FCTR_PERCENTUALFRETE;
    const CTR_PERCENTUALFRETE_Name = 'CTR_PERCENTUALFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORQUILOFRETE', ftBCD)]
    [Dictionary('CTR_VALORQUILOFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORQUILOFRETE: Double read FCTR_VALORQUILOFRETE write FCTR_VALORQUILOFRETE;
    const CTR_VALORQUILOFRETE_Name = 'CTR_VALORQUILOFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALSEC_CAT', ftBCD)]
    [Dictionary('CTR_TOTALSEC_CAT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALSEC_CAT: Double read FCTR_TOTALSEC_CAT write FCTR_TOTALSEC_CAT;
    const CTR_TOTALSEC_CAT_Name = 'CTR_TOTALSEC_CAT';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALPIS', ftBCD)]
    [Dictionary('CTR_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALPIS: Double read FCTR_PERCENTUALPIS write FCTR_PERCENTUALPIS;
    const CTR_PERCENTUALPIS_Name = 'CTR_PERCENTUALPIS';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROCIOT', ftString, 12)]
    [Dictionary('CTR_NUMEROCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROCIOT: String read FCTR_NUMEROCIOT write FCTR_NUMEROCIOT;
    const CTR_NUMEROCIOT_Name = 'CTR_NUMEROCIOT';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOCTR', ftString, 2)]
    [Dictionary('CST_CODIGOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOCTR: String read FCST_CODIGOCTR write FCST_CODIGOCTR;
    const CST_CODIGOCTR_Name = 'CST_CODIGOCTR';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CTR_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPESOBRUTO: Double read FCTR_TOTALPESOBRUTO write FCTR_TOTALPESOBRUTO;
    const CTR_TOTALPESOBRUTO_Name = 'CTR_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('CTR_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALAPROXIMADOIMPOSTO: Double read FCTR_TOTALAPROXIMADOIMPOSTO write FCTR_TOTALAPROXIMADOIMPOSTO;
    const CTR_TOTALAPROXIMADOIMPOSTO_Name = 'CTR_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('CTR_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALIBPTESTADUAL: Double read FCTR_TOTALIBPTESTADUAL write FCTR_TOTALIBPTESTADUAL;
    const CTR_TOTALIBPTESTADUAL_Name = 'CTR_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('CTR_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALIBPTNACIONAL: Double read FCTR_TOTALIBPTNACIONAL write FCTR_TOTALIBPTNACIONAL;
    const CTR_TOTALIBPTNACIONAL_Name = 'CTR_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPT', ftBCD)]
    [Dictionary('CTR_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPT: Double read FCTR_PERCENTUALIBPT write FCTR_PERCENTUALIBPT;
    const CTR_PERCENTUALIBPT_Name = 'CTR_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('CTR_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPTESTADUAL: Double read FCTR_PERCENTUALIBPTESTADUAL write FCTR_PERCENTUALIBPTESTADUAL;
    const CTR_PERCENTUALIBPTESTADUAL_Name = 'CTR_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('CTR_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPTNACIONAL: Double read FCTR_PERCENTUALIBPTNACIONAL write FCTR_PERCENTUALIBPTNACIONAL;
    const CTR_PERCENTUALIBPTNACIONAL_Name = 'CTR_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('CTR_CNPJTOMADOR', ftString, 14)]
    [Dictionary('CTR_CNPJTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CNPJTOMADOR: String read FCTR_CNPJTOMADOR write FCTR_CNPJTOMADOR;
    const CTR_CNPJTOMADOR_Name = 'CTR_CNPJTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_CPFTOMADOR', ftString, 11)]
    [Dictionary('CTR_CPFTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CPFTOMADOR: String read FCTR_CPFTOMADOR write FCTR_CPFTOMADOR;
    const CTR_CPFTOMADOR_Name = 'CTR_CPFTOMADOR';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOTOMADOR', ftString, 2)]
    [Dictionary('MNF_CODIGOTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOTOMADOR: String read FMNF_CODIGOTOMADOR write FMNF_CODIGOTOMADOR;
    const MNF_CODIGOTOMADOR_Name = 'MNF_CODIGOTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIETOMADOR', ftString, 3)]
    [Dictionary('CTR_SERIETOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIETOMADOR: String read FCTR_SERIETOMADOR write FCTR_SERIETOMADOR;
    const CTR_SERIETOMADOR_Name = 'CTR_SERIETOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_SUBSERIETOMADOR', ftString, 3)]
    [Dictionary('CTR_SUBSERIETOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SUBSERIETOMADOR: String read FCTR_SUBSERIETOMADOR write FCTR_SUBSERIETOMADOR;
    const CTR_SUBSERIETOMADOR_Name = 'CTR_SUBSERIETOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCALTOMADOR', ftString, 6)]
    [Dictionary('CTR_NOTAFISCALTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCALTOMADOR: String read FCTR_NOTAFISCALTOMADOR write FCTR_NOTAFISCALTOMADOR;
    const CTR_NOTAFISCALTOMADOR_Name = 'CTR_NOTAFISCALTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORNOTAFISCALTOMADOR', ftBCD)]
    [Dictionary('CTR_VALORNOTAFISCALTOMADOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORNOTAFISCALTOMADOR: Double read FCTR_VALORNOTAFISCALTOMADOR write FCTR_VALORNOTAFISCALTOMADOR;
    const CTR_VALORNOTAFISCALTOMADOR_Name = 'CTR_VALORNOTAFISCALTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAONFTOMADOR', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAONFTOMADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAONFTOMADOR: TDateTime read FCTR_DATAEMISSAONFTOMADOR write FCTR_DATAEMISSAONFTOMADOR;
    const CTR_DATAEMISSAONFTOMADOR_Name = 'CTR_DATAEMISSAONFTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_TOMADORCONTRIBUINTEICMS', ftString, 1)]
    [Dictionary('CTR_TOMADORCONTRIBUINTEICMS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TOMADORCONTRIBUINTEICMS: String read FCTR_TOMADORCONTRIBUINTEICMS write FCTR_TOMADORCONTRIBUINTEICMS;
    const CTR_TOMADORCONTRIBUINTEICMS_Name = 'CTR_TOMADORCONTRIBUINTEICMS';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSOTOMADOR', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSOTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSOTOMADOR: String read FCTR_CHAVEACESSOTOMADOR write FCTR_CHAVEACESSOTOMADOR;
    const CTR_CHAVEACESSOTOMADOR_Name = 'CTR_CHAVEACESSOTOMADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSOSUBSTITUIDO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSOSUBSTITUIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSOSUBSTITUIDO: String read FCTR_CHAVEACESSOSUBSTITUIDO write FCTR_CHAVEACESSOSUBSTITUIDO;
    const CTR_CHAVEACESSOSUBSTITUIDO_Name = 'CTR_CHAVEACESSOSUBSTITUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSOCOMPLEMENTO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSOCOMPLEMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSOCOMPLEMENTO: String read FCTR_CHAVEACESSOCOMPLEMENTO write FCTR_CHAVEACESSOCOMPLEMENTO;
    const CTR_CHAVEACESSOCOMPLEMENTO_Name = 'CTR_CHAVEACESSOCOMPLEMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSOANULACAO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSOANULACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSOANULACAO: String read FCTR_CHAVEACESSOANULACAO write FCTR_CHAVEACESSOANULACAO;
    const CTR_CHAVEACESSOANULACAO_Name = 'CTR_CHAVEACESSOANULACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAODECLARACAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAODECLARACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAODECLARACAO: TDateTime read FCTR_DATAEMISSAODECLARACAO write FCTR_DATAEMISSAODECLARACAO;
    const CTR_DATAEMISSAODECLARACAO_Name = 'CTR_DATAEMISSAODECLARACAO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftInteger)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEORIGEM: Integer read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CTR_CIDADEORIGEM', ftString, 100)]
    [Dictionary('CTR_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CIDADEORIGEM: String read FCTR_CIDADEORIGEM write FCTR_CIDADEORIGEM;
    const CTR_CIDADEORIGEM_Name = 'CTR_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CTR_UFORIGEM', ftString, 2)]
    [Dictionary('CTR_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UFORIGEM: String read FCTR_UFORIGEM write FCTR_UFORIGEM;
    const CTR_UFORIGEM_Name = 'CTR_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftInteger)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEDESTINO: Integer read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CTR_CIDADEDESTINO', ftString, 100)]
    [Dictionary('CTR_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CIDADEDESTINO: String read FCTR_CIDADEDESTINO write FCTR_CIDADEDESTINO;
    const CTR_CIDADEDESTINO_Name = 'CTR_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CTR_UFDESTINO', ftString, 2)]
    [Dictionary('CTR_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UFDESTINO: String read FCTR_UFDESTINO write FCTR_UFDESTINO;
    const CTR_UFDESTINO_Name = 'CTR_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

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
    [Column('CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO: String read FCTR_OBSERVACAO write FCTR_OBSERVACAO;
    const CTR_OBSERVACAO_Name = 'CTR_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_CANCELADO', ftString, 1)]
    [Dictionary('CTR_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CANCELADO: String read FCTR_CANCELADO write FCTR_CANCELADO;
    const CTR_CANCELADO_Name = 'CTR_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_LIVROFISCAL', ftString, 1)]
    [Dictionary('CTR_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_LIVROFISCAL: String read FCTR_LIVROFISCAL write FCTR_LIVROFISCAL;
    const CTR_LIVROFISCAL_Name = 'CTR_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_PROCESSADO', ftString, 1)]
    [Dictionary('CTR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROCESSADO: String read FCTR_PROCESSADO write FCTR_PROCESSADO;
    const CTR_PROCESSADO_Name = 'CTR_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAALTERACAO: TDateTime read FCTR_DATAALTERACAO write FCTR_DATAALTERACAO;
    const CTR_DATAALTERACAO_Name = 'CTR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID: Integer read FLIB_ID write FLIB_ID;
    const LIB_ID_Name = 'LIB_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_AVERBADO', ftString, 1)]
    [Dictionary('CTR_AVERBADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AVERBADO: String read FCTR_AVERBADO write FCTR_AVERBADO;
    const CTR_AVERBADO_Name = 'CTR_AVERBADO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOMESEGURADORA', ftString, 40)]
    [Dictionary('CTR_NOMESEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOMESEGURADORA: String read FCTR_NOMESEGURADORA write FCTR_NOMESEGURADORA;
    const CTR_NOMESEGURADORA_Name = 'CTR_NOMESEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_CNPJSEGURADORA', ftString, 14)]
    [Dictionary('CTR_CNPJSEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CNPJSEGURADORA: String read FCTR_CNPJSEGURADORA write FCTR_CNPJSEGURADORA;
    const CTR_CNPJSEGURADORA_Name = 'CTR_CNPJSEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROAPOLICE', ftString, 40)]
    [Dictionary('CTR_NUMEROAPOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROAPOLICE: String read FCTR_NUMEROAPOLICE write FCTR_NUMEROAPOLICE;
    const CTR_NUMEROAPOLICE_Name = 'CTR_NUMEROAPOLICE';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROAVERBACAO', ftString, 40)]
    [Dictionary('CTR_NUMEROAVERBACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROAVERBACAO: String read FCTR_NUMEROAVERBACAO write FCTR_NUMEROAVERBACAO;
    const CTR_NUMEROAVERBACAO_Name = 'CTR_NUMEROAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAAVERBACAO', ftDateTime)]
    [Dictionary('CTR_DATAAVERBACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAAVERBACAO: TDateTime read FCTR_DATAAVERBACAO write FCTR_DATAAVERBACAO;
    const CTR_DATAAVERBACAO_Name = 'CTR_DATAAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_HORAAVERBACAO', ftString, 8)]
    [Dictionary('CTR_HORAAVERBACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_HORAAVERBACAO: String read FCTR_HORAAVERBACAO write FCTR_HORAAVERBACAO;
    const CTR_HORAAVERBACAO_Name = 'CTR_HORAAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_PROTOCOLOAVERBACAO', ftString, 40)]
    [Dictionary('CTR_PROTOCOLOAVERBACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROTOCOLOAVERBACAO: String read FCTR_PROTOCOLOAVERBACAO write FCTR_PROTOCOLOAVERBACAO;
    const CTR_PROTOCOLOAVERBACAO_Name = 'CTR_PROTOCOLOAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_QUANTIDADECARGA', ftBCD, 18, 4)]
    [Dictionary('CTR_QUANTIDADECARGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_QUANTIDADECARGA: Double read FCTR_QUANTIDADECARGA write FCTR_QUANTIDADECARGA;
    const CTR_QUANTIDADECARGA_Name = 'CTR_QUANTIDADECARGA';

    [Restrictions([NoValidate])]
    [Column('CTR_UNIDADEMENIDACARGA', ftString, 2)]
    [Dictionary('CTR_UNIDADEMENIDACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UNIDADEMENIDACARGA: String read FCTR_UNIDADEMENIDACARGA write FCTR_UNIDADEMENIDACARGA;
    const CTR_UNIDADEMENIDACARGA_Name = 'CTR_UNIDADEMENIDACARGA';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LIB_ID_OLD', ftInteger)]
    [Dictionary('LIB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID_OLD: Integer read FLIB_ID_OLD write FLIB_ID_OLD;
    const LIB_ID_OLD_Name = 'LIB_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_UNIDADEMEDIDACARGA', ftString, 2)]
    [Dictionary('CTR_UNIDADEMEDIDACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UNIDADEMEDIDACARGA: String read FCTR_UNIDADEMEDIDACARGA write FCTR_UNIDADEMEDIDACARGA;
    const CTR_UNIDADEMEDIDACARGA_Name = 'CTR_UNIDADEMEDIDACARGA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_00)

end.
