unit express.dbo.CTR_BAIXACANHOTO;

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
  [Table('CTR_BaixaCanhoto', '')]
  TDtoCTR_BaixaCanhoto = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAENTREGA: TDateTime;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FCTR_NOTAFISCAL: String;
    FVEI_CODIGO: Integer;
    FCTR_PLACAVEICULO: String;
    FCTR_UFVEICULO: String;
    FPRO_CODIGO: Integer;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
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
    FCTR_TOTALPRESTACAO: Double;
    FCTR_TOTALNOTAFISCAL: Double;
    FCTR_TOTALPESOLIQUIDO: Double;
    FCTR_TOTALPESOBRUTO: Double;
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
    FPES_CLIENTEREMETENTE: Integer;
    FPES_TIPOPESSOA_CLIENTEREMETENTE: String;
    FPES_NOMECLIENTEREMETENTE: String;
    FPES_CNPJ_CPF_CLIENTEREMETENTE: String;
    FPES_IE_CI_CLIENTEREMETENTE: String;
    FPES_CEP_CLIENTEREMETENTE: String;
    FPES_CIDADE_CLIENTEREMETENTE: String;
    FPES_UF_CLIENTEREMETENTE: String;
    FPES_ENDERECO_CLIENTEREMETENTE: String;
    FPES_NUMEROENDERECO_CLIENTEREMETENTE: String;
    FPES_BAIRRO_CLIENTEREMETENTE: String;
    FPES_DDD_TELEFONE_1_CLIENTEREMETENTE: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_TIPOPESSOA_CLIENTEDESTINATARIO: String;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_CNPJ_CPF_CLIENTEDESTINATARIO: String;
    FPES_IE_CI_CLIENTEDESTINATARIO: String;
    FPES_CEP_CLIENTEDESTINATARIO: String;
    FPES_CIDADE_CLIENTEDESTINATARIO: String;
    FPES_UF_CLIENTEDESTINATARIO: String;
    FPES_ENDERECO_CLIENTEDESTINATARIO: String;
    FPES_NUMEROENDERECO_CLIENTEDESTINATARIO: String;
    FPES_BAIRRO_CLIENTEDESTINATARIO: String;
    FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO: String;
    FCTR_SERIE_01: String;
    FMNF_CODIGO_01: String;
    FCTR_DATAEMISSAO_01: TDateTime;
    FCTR_ORDEMITEM: Integer;
    FCTR_NOTAFISCAL_01: String;
    FCTR_VALORNOTAFISCAL: Double;
    FCTR_VALORSEMIPI: Double;
    FCTR_VALORCOMIPI: Double;
    FCTR_PESOLIQUIDO: Double;
    FCTR_PESOBRUTO: Double;
    FCTR_DATARECEBIMENTO: TDateTime;
    FCTR_NOMERECEPTOR: String;
    FCTR_OBSERVACAO_01: String;
    FCTR_PESOLIQUIDORECEBIMENTO: Double;
    FCTR_BAIXADO: String;
    FCTR_NUMEROVOLUMES: Double;
    FCTR_CHAVEACESSO: String;
    FCTR_STATUSBAIXA: String;
  public 
    { Public declarations } 
     const Table      = 'CTR_BaixaCanhoto';

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
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_PLACAVEICULO', ftString, 7)]
    [Dictionary('CTR_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PLACAVEICULO: String read FCTR_PLACAVEICULO write FCTR_PLACAVEICULO;
    const CTR_PLACAVEICULO_Name = 'CTR_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('CTR_UFVEICULO', ftString, 2)]
    [Dictionary('CTR_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UFVEICULO: String read FCTR_UFVEICULO write FCTR_UFVEICULO;
    const CTR_UFVEICULO_Name = 'CTR_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

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
    [Column('CTR_TOTALDESPACHO', ftBCD)]
    [Dictionary('CTR_TOTALDESPACHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALDESPACHO: Double read FCTR_TOTALDESPACHO write FCTR_TOTALDESPACHO;
    const CTR_TOTALDESPACHO_Name = 'CTR_TOTALDESPACHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PERCENTUALICMS', ftBCD)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

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

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CTR_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPESOBRUTO: Double read FCTR_TOTALPESOBRUTO write FCTR_TOTALPESOBRUTO;
    const CTR_TOTALPESOBRUTO_Name = 'CTR_TOTALPESOBRUTO';

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
    [Column('PES_ENDERECO_CLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEREMETENTE: String read FPES_ENDERECO_CLIENTEREMETENTE write FPES_ENDERECO_CLIENTEREMETENTE;
    const PES_ENDERECO_CLIENTEREMETENTE_Name = 'PES_ENDERECO_CLIENTEREMETENTE';

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
    [Column('PES_ENDERECO_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEDESTINATARIO: String read FPES_ENDERECO_CLIENTEDESTINATARIO write FPES_ENDERECO_CLIENTEDESTINATARIO;
    const PES_ENDERECO_CLIENTEDESTINATARIO_Name = 'PES_ENDERECO_CLIENTEDESTINATARIO';

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
    [Column('CTR_SERIE_01', ftString, 3)]
    [Dictionary('CTR_SERIE_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE_01: String read FCTR_SERIE_01 write FCTR_SERIE_01;
    const CTR_SERIE_01_Name = 'CTR_SERIE_01';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO_01', ftString, 2)]
    [Dictionary('MNF_CODIGO_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO_01: String read FMNF_CODIGO_01 write FMNF_CODIGO_01;
    const MNF_CODIGO_01_Name = 'MNF_CODIGO_01';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO_01', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO_01', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO_01: TDateTime read FCTR_DATAEMISSAO_01 write FCTR_DATAEMISSAO_01;
    const CTR_DATAEMISSAO_01_Name = 'CTR_DATAEMISSAO_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ORDEMITEM', ftInteger)]
    [Dictionary('CTR_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ORDEMITEM: Integer read FCTR_ORDEMITEM write FCTR_ORDEMITEM;
    const CTR_ORDEMITEM_Name = 'CTR_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL_01', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL_01: String read FCTR_NOTAFISCAL_01 write FCTR_NOTAFISCAL_01;
    const CTR_NOTAFISCAL_01_Name = 'CTR_NOTAFISCAL_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORNOTAFISCAL: Double read FCTR_VALORNOTAFISCAL write FCTR_VALORNOTAFISCAL;
    const CTR_VALORNOTAFISCAL_Name = 'CTR_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORSEMIPI', ftBCD)]
    [Dictionary('CTR_VALORSEMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORSEMIPI: Double read FCTR_VALORSEMIPI write FCTR_VALORSEMIPI;
    const CTR_VALORSEMIPI_Name = 'CTR_VALORSEMIPI';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORCOMIPI', ftBCD)]
    [Dictionary('CTR_VALORCOMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORCOMIPI: Double read FCTR_VALORCOMIPI write FCTR_VALORCOMIPI;
    const CTR_VALORCOMIPI_Name = 'CTR_VALORCOMIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDO: Double read FCTR_PESOLIQUIDO write FCTR_PESOLIQUIDO;
    const CTR_PESOLIQUIDO_Name = 'CTR_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOBRUTO: Double read FCTR_PESOBRUTO write FCTR_PESOBRUTO;
    const CTR_PESOBRUTO_Name = 'CTR_PESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATARECEBIMENTO', ftDateTime)]
    [Dictionary('CTR_DATARECEBIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATARECEBIMENTO: TDateTime read FCTR_DATARECEBIMENTO write FCTR_DATARECEBIMENTO;
    const CTR_DATARECEBIMENTO_Name = 'CTR_DATARECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOMERECEPTOR', ftString, 50)]
    [Dictionary('CTR_NOMERECEPTOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOMERECEPTOR: String read FCTR_NOMERECEPTOR write FCTR_NOMERECEPTOR;
    const CTR_NOMERECEPTOR_Name = 'CTR_NOMERECEPTOR';

    [Restrictions([NoValidate])]
    [Column('CTR_OBSERVACAO_01', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO_01: String read FCTR_OBSERVACAO_01 write FCTR_OBSERVACAO_01;
    const CTR_OBSERVACAO_01_Name = 'CTR_OBSERVACAO_01';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOLIQUIDORECEBIMENTO', ftBCD)]
    [Dictionary('CTR_PESOLIQUIDORECEBIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDORECEBIMENTO: Double read FCTR_PESOLIQUIDORECEBIMENTO write FCTR_PESOLIQUIDORECEBIMENTO;
    const CTR_PESOLIQUIDORECEBIMENTO_Name = 'CTR_PESOLIQUIDORECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_BAIXADO', ftString, 1)]
    [Dictionary('CTR_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_BAIXADO: String read FCTR_BAIXADO write FCTR_BAIXADO;
    const CTR_BAIXADO_Name = 'CTR_BAIXADO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_NUMEROVOLUMES: Double read FCTR_NUMEROVOLUMES write FCTR_NUMEROVOLUMES;
    const CTR_NUMEROVOLUMES_Name = 'CTR_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSO: String read FCTR_CHAVEACESSO write FCTR_CHAVEACESSO;
    const CTR_CHAVEACESSO_Name = 'CTR_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('CTR_STATUSBAIXA', ftString, 1)]
    [Dictionary('CTR_STATUSBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_STATUSBAIXA: String read FCTR_STATUSBAIXA write FCTR_STATUSBAIXA;
    const CTR_STATUSBAIXA_Name = 'CTR_STATUSBAIXA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_BaixaCanhoto)

end.
