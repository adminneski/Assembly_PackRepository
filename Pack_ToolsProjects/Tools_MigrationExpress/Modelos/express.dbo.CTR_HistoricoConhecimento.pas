unit express.dbo.CTR_HISTORICOCONHECIMENTO;

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
  [Table('CTR_HistoricoConhecimento', '')]
  TDtoCTR_HistoricoConhecimento = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCLT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAPREVISAOENTREGA: TDateTime;
    FCTR_SERIE: String;
    FCTR_MNF_CODIGO: String;
    FCTR_NOTAFISCAL: String;
    FCTR_CFOP_CODIGO: String;
    FCLT_SERIE: String;
    FCLT_MNF_CODIGO: String;
    FCLT_CFOP_CODIGO: String;
    FCLT_DATACOLETA: TDateTime;
    FCLT_DATAEMISSAO: TDateTime;
    FCLT_NOTAFISCAL: String;
    FCLT_CHAVEACESSO: String;
    FCLT_NUMEROVOLUMES: Double;
    FCLT_PESOLIQUIDO: Double;
    FCTR_EMITENTE: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_NOMECLIENTEREMETENTE: String;
    FCID_IBGE_CLIENTEREMETENTE: String;
    FPES_CIDADE_CLIENTEREMETENTE: String;
    FPES_UF_CLIENTEREMETENTE: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FCID_IBGE_CLIENTEDESTINATARIO: String;
    FPES_CIDADE_CLIENTEDESTINATARIO: String;
    FPES_UF_CLIENTEDESTINATARIO: String;
    FCTR_TOTALNOTAFISCAL: Double;
    FCTR_TOTALPESOLIQUIDO: Double;
    FCTR_TOTALNUMEROVOLUMES: Double;
    FCTR_PROCESSADO: String;
    FCTR_OBSERVACAO: String;
    FCTR_LIVROFISCAL: String;
    FCTR_CANCELADO: String;
    FCTR_DATAALTERACAO: TDateTime;
    FCTR_DATACANCELAMENTO: TDateTime;
    FCTR_OBSERVACAOCANCELAMENTO: String;
    FNF_MNF_CODIGO: String;
    FNF_CTR_DATAEMISSAO: TDateTime;
    FNF_CTR_NOTAFISCAL: String;
    FNF_CTR_VALORNOTAFISCAL: Double;
    FNF_CTR_NUMEROVOLUMES: Double;
    FNF_CTR_PESOLIQUIDO: Double;
    FNF_CTR_DATAALTERACAO: TDateTime;
    FNF_CTR_DATARECEBIMENTO: TDateTime;
    FNF_CTR_NOMERECEPTOR: String;
    FNF_CTR_OBSERVACAO: String;
    FNF_CTR_PESOLIQUIDORECEBIMENTO: Double;
    FNF_CTR_CHAVEACESSO: String;
    FNF_CTR_BAIXADO: String;
    FNF_CTR_VALORPRODUTOS: Double;
    FNF_CFOP_CODIGO: String;
    FNF_TOTALICMS: Double;
    FNF_TOTALPRODUTOS: Double;
    FNF_TOTALNOTAFISCAL: Double;
    FNF_TOTALBASECALCULOICMS: Double;
    FNF_TOTALBASECALCULOMVA: Double;
    FNF_TOTALSUBSTRIBUTARIA: Double;
    FCLT_STATUS: String;
    FCLT_DESATIVADO: String;
    FCLT_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'CTR_HistoricoConhecimento';

    [Restrictions([NoValidate])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CLT_ID', ftInteger)]
    [Dictionary('CLT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLT_ID: Integer read FCLT_ID write FCLT_ID;
    const CLT_ID_Name = 'CLT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAPREVISAOENTREGA', ftDateTime)]
    [Dictionary('CTR_DATAPREVISAOENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAPREVISAOENTREGA: TDateTime read FCTR_DATAPREVISAOENTREGA write FCTR_DATAPREVISAOENTREGA;
    const CTR_DATAPREVISAOENTREGA_Name = 'CTR_DATAPREVISAOENTREGA';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_MNF_CODIGO', ftString, 2)]
    [Dictionary('CTR_MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_MNF_CODIGO: String read FCTR_MNF_CODIGO write FCTR_MNF_CODIGO;
    const CTR_MNF_CODIGO_Name = 'CTR_MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_CFOP_CODIGO', ftString, 4)]
    [Dictionary('CTR_CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CFOP_CODIGO: String read FCTR_CFOP_CODIGO write FCTR_CFOP_CODIGO;
    const CTR_CFOP_CODIGO_Name = 'CTR_CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLT_SERIE', ftString, 3)]
    [Dictionary('CLT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_SERIE: String read FCLT_SERIE write FCLT_SERIE;
    const CLT_SERIE_Name = 'CLT_SERIE';

    [Restrictions([NoValidate])]
    [Column('CLT_MNF_CODIGO', ftString, 2)]
    [Dictionary('CLT_MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_MNF_CODIGO: String read FCLT_MNF_CODIGO write FCLT_MNF_CODIGO;
    const CLT_MNF_CODIGO_Name = 'CLT_MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLT_CFOP_CODIGO', ftString, 4)]
    [Dictionary('CLT_CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_CFOP_CODIGO: String read FCLT_CFOP_CODIGO write FCLT_CFOP_CODIGO;
    const CLT_CFOP_CODIGO_Name = 'CLT_CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLT_DATACOLETA', ftDateTime)]
    [Dictionary('CLT_DATACOLETA', 'Mensagem de validação', '', '', '', taCenter)]
    property CLT_DATACOLETA: TDateTime read FCLT_DATACOLETA write FCLT_DATACOLETA;
    const CLT_DATACOLETA_Name = 'CLT_DATACOLETA';

    [Restrictions([NoValidate])]
    [Column('CLT_DATAEMISSAO', ftDateTime)]
    [Dictionary('CLT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CLT_DATAEMISSAO: TDateTime read FCLT_DATAEMISSAO write FCLT_DATAEMISSAO;
    const CLT_DATAEMISSAO_Name = 'CLT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CLT_NOTAFISCAL', ftString, 9)]
    [Dictionary('CLT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_NOTAFISCAL: String read FCLT_NOTAFISCAL write FCLT_NOTAFISCAL;
    const CLT_NOTAFISCAL_Name = 'CLT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CLT_CHAVEACESSO', ftString, 44)]
    [Dictionary('CLT_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_CHAVEACESSO: String read FCLT_CHAVEACESSO write FCLT_CHAVEACESSO;
    const CLT_CHAVEACESSO_Name = 'CLT_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('CLT_NUMEROVOLUMES', ftBCD)]
    [Dictionary('CLT_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_NUMEROVOLUMES: Double read FCLT_NUMEROVOLUMES write FCLT_NUMEROVOLUMES;
    const CLT_NUMEROVOLUMES_Name = 'CLT_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CLT_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CLT_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_PESOLIQUIDO: Double read FCLT_PESOLIQUIDO write FCLT_PESOLIQUIDO;
    const CLT_PESOLIQUIDO_Name = 'CLT_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMITENTE', ftString, 1)]
    [Dictionary('CTR_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMITENTE: String read FCTR_EMITENTE write FCTR_EMITENTE;
    const CTR_EMITENTE_Name = 'CTR_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREMETENTE: String read FPES_NOMECLIENTEREMETENTE write FPES_NOMECLIENTEREMETENTE;
    const PES_NOMECLIENTEREMETENTE_Name = 'PES_NOMECLIENTEREMETENTE';

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
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEDESTINATARIO: String read FPES_NOMECLIENTEDESTINATARIO write FPES_NOMECLIENTEDESTINATARIO;
    const PES_NOMECLIENTEDESTINATARIO_Name = 'PES_NOMECLIENTEDESTINATARIO';

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
    [Column('CTR_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNOTAFISCAL: Double read FCTR_TOTALNOTAFISCAL write FCTR_TOTALNOTAFISCAL;
    const CTR_TOTALNOTAFISCAL_Name = 'CTR_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPESOLIQUIDO: Double read FCTR_TOTALPESOLIQUIDO write FCTR_TOTALPESOLIQUIDO;
    const CTR_TOTALPESOLIQUIDO_Name = 'CTR_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNUMEROVOLUMES: Double read FCTR_TOTALNUMEROVOLUMES write FCTR_TOTALNUMEROVOLUMES;
    const CTR_TOTALNUMEROVOLUMES_Name = 'CTR_TOTALNUMEROVOLUMES';

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

    [Restrictions([NoValidate])]
    [Column('CTR_LIVROFISCAL', ftString, 1)]
    [Dictionary('CTR_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_LIVROFISCAL: String read FCTR_LIVROFISCAL write FCTR_LIVROFISCAL;
    const CTR_LIVROFISCAL_Name = 'CTR_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_CANCELADO', ftString, 1)]
    [Dictionary('CTR_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CANCELADO: String read FCTR_CANCELADO write FCTR_CANCELADO;
    const CTR_CANCELADO_Name = 'CTR_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
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
    [Column('NF_MNF_CODIGO', ftString, 2)]
    [Dictionary('NF_MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_MNF_CODIGO: String read FNF_MNF_CODIGO write FNF_MNF_CODIGO;
    const NF_MNF_CODIGO_Name = 'NF_MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('NF_CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NF_CTR_DATAEMISSAO: TDateTime read FNF_CTR_DATAEMISSAO write FNF_CTR_DATAEMISSAO;
    const NF_CTR_DATAEMISSAO_Name = 'NF_CTR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('NF_CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CTR_NOTAFISCAL: String read FNF_CTR_NOTAFISCAL write FNF_CTR_NOTAFISCAL;
    const NF_CTR_NOTAFISCAL_Name = 'NF_CTR_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_CTR_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('NF_CTR_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_CTR_VALORNOTAFISCAL: Double read FNF_CTR_VALORNOTAFISCAL write FNF_CTR_VALORNOTAFISCAL;
    const NF_CTR_VALORNOTAFISCAL_Name = 'NF_CTR_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_NUMEROVOLUMES', ftBCD)]
    [Dictionary('NF_CTR_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_CTR_NUMEROVOLUMES: Double read FNF_CTR_NUMEROVOLUMES write FNF_CTR_NUMEROVOLUMES;
    const NF_CTR_NUMEROVOLUMES_Name = 'NF_CTR_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_CTR_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('NF_CTR_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_CTR_PESOLIQUIDO: Double read FNF_CTR_PESOLIQUIDO write FNF_CTR_PESOLIQUIDO;
    const NF_CTR_PESOLIQUIDO_Name = 'NF_CTR_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('NF_CTR_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NF_CTR_DATAALTERACAO: TDateTime read FNF_CTR_DATAALTERACAO write FNF_CTR_DATAALTERACAO;
    const NF_CTR_DATAALTERACAO_Name = 'NF_CTR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_DATARECEBIMENTO', ftDateTime)]
    [Dictionary('NF_CTR_DATARECEBIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NF_CTR_DATARECEBIMENTO: TDateTime read FNF_CTR_DATARECEBIMENTO write FNF_CTR_DATARECEBIMENTO;
    const NF_CTR_DATARECEBIMENTO_Name = 'NF_CTR_DATARECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_NOMERECEPTOR', ftString, 50)]
    [Dictionary('NF_CTR_NOMERECEPTOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CTR_NOMERECEPTOR: String read FNF_CTR_NOMERECEPTOR write FNF_CTR_NOMERECEPTOR;
    const NF_CTR_NOMERECEPTOR_Name = 'NF_CTR_NOMERECEPTOR';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('NF_CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CTR_OBSERVACAO: String read FNF_CTR_OBSERVACAO write FNF_CTR_OBSERVACAO;
    const NF_CTR_OBSERVACAO_Name = 'NF_CTR_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_PESOLIQUIDORECEBIMENTO', ftBCD)]
    [Dictionary('NF_CTR_PESOLIQUIDORECEBIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_CTR_PESOLIQUIDORECEBIMENTO: Double read FNF_CTR_PESOLIQUIDORECEBIMENTO write FNF_CTR_PESOLIQUIDORECEBIMENTO;
    const NF_CTR_PESOLIQUIDORECEBIMENTO_Name = 'NF_CTR_PESOLIQUIDORECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('NF_CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CTR_CHAVEACESSO: String read FNF_CTR_CHAVEACESSO write FNF_CTR_CHAVEACESSO;
    const NF_CTR_CHAVEACESSO_Name = 'NF_CTR_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_BAIXADO', ftString, 1)]
    [Dictionary('NF_CTR_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CTR_BAIXADO: String read FNF_CTR_BAIXADO write FNF_CTR_BAIXADO;
    const NF_CTR_BAIXADO_Name = 'NF_CTR_BAIXADO';

    [Restrictions([NoValidate])]
    [Column('NF_CTR_VALORPRODUTOS', ftBCD)]
    [Dictionary('NF_CTR_VALORPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_CTR_VALORPRODUTOS: Double read FNF_CTR_VALORPRODUTOS write FNF_CTR_VALORPRODUTOS;
    const NF_CTR_VALORPRODUTOS_Name = 'NF_CTR_VALORPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('NF_CFOP_CODIGO', ftString, 4)]
    [Dictionary('NF_CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NF_CFOP_CODIGO: String read FNF_CFOP_CODIGO write FNF_CFOP_CODIGO;
    const NF_CFOP_CODIGO_Name = 'NF_CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALICMS', ftBCD)]
    [Dictionary('NF_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALICMS: Double read FNF_TOTALICMS write FNF_TOTALICMS;
    const NF_TOTALICMS_Name = 'NF_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALPRODUTOS', ftBCD)]
    [Dictionary('NF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALPRODUTOS: Double read FNF_TOTALPRODUTOS write FNF_TOTALPRODUTOS;
    const NF_TOTALPRODUTOS_Name = 'NF_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NF_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALNOTAFISCAL: Double read FNF_TOTALNOTAFISCAL write FNF_TOTALNOTAFISCAL;
    const NF_TOTALNOTAFISCAL_Name = 'NF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOICMS: Double read FNF_TOTALBASECALCULOICMS write FNF_TOTALBASECALCULOICMS;
    const NF_TOTALBASECALCULOICMS_Name = 'NF_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('NF_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALBASECALCULOMVA: Double read FNF_TOTALBASECALCULOMVA write FNF_TOTALBASECALCULOMVA;
    const NF_TOTALBASECALCULOMVA_Name = 'NF_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('NF_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('NF_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NF_TOTALSUBSTRIBUTARIA: Double read FNF_TOTALSUBSTRIBUTARIA write FNF_TOTALSUBSTRIBUTARIA;
    const NF_TOTALSUBSTRIBUTARIA_Name = 'NF_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('CLT_STATUS', ftString, 1)]
    [Dictionary('CLT_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_STATUS: String read FCLT_STATUS write FCLT_STATUS;
    const CLT_STATUS_Name = 'CLT_STATUS';

    [Restrictions([NoValidate])]
    [Column('CLT_DESATIVADO', ftString, 1)]
    [Dictionary('CLT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_DESATIVADO: String read FCLT_DESATIVADO write FCLT_DESATIVADO;
    const CLT_DESATIVADO_Name = 'CLT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CLT_DATAALTERACAO', ftDateTime)]
    [Dictionary('CLT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CLT_DATAALTERACAO: TDateTime read FCLT_DATAALTERACAO write FCLT_DATAALTERACAO;
    const CLT_DATAALTERACAO_Name = 'CLT_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_HistoricoConhecimento)

end.
