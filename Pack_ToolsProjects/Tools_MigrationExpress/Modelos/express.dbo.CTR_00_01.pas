unit express.dbo.CTR_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ctr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CTR_00_01', '')]
  [PrimaryKey('CTR_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTR_01_ID')]
  TDtoCTR_00_01 = class
  private
    { Private declarations } 
    FCTR_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_SERIE: String;
    FMNF_CODIGO: String;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_ORDEMITEM: Integer;
    FCTR_NOTAFISCAL: String;
    FCTR_VALORNOTAFISCAL: Double;
    FCTR_NUMEROVOLUMES: Double;
    FCTR_VALORSEMIPI: Double;
    FCTR_VALORCOMIPI: Double;
    FCTR_PESOLIQUIDO: Double;
    FCTR_DATAALTERACAO: TDateTime;
    FCTR_DATARECEBIMENTO: TDateTime;
    FCTR_NOMERECEPTOR: String;
    FCTR_OBSERVACAO: String;
    FCTR_PESOLIQUIDORECEBIMENTO: Double;
    FCTR_CHAVEACESSO: String;
    FCTR_BAIXADO: String;
    FCTR_NUMEROROMANEIO: String;
    FCTR_NUMEROPEDIDO: String;
    FCTR_VALORBASECALCULOICMS: Double;
    FCTR_VALORBASECALCULOMVA: Double;
    FCTR_VALORSUBSTRIBUTARIA: Double;
    FCTR_VALORPRODUTOS: Double;
    FCFOP_CODIGO: String;
    FCTR_VALORICMS: Double;
    FCLT_ID: Integer;
    FCTR_PESOBRUTO: Double;
    FCTR_ETIQUETAIMPRESSA: String;
    FCTR_STATUSBAIXA: String;
    FCTR_01_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
    FCLT_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CTR_00_01';
    const PrimaryKey = 'CTR_01_ID';
    const Sequence   = 'SEQ_CTR_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_01_ID', ftInteger)]
    [Dictionary('CTR_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_01_ID: Integer read FCTR_01_ID write FCTR_01_ID;
    const CTR_01_ID_Name = 'CTR_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [ForeignKey('CTR_00_01_fk', 'CTR_ID', 'CTR_00', 'CTR_ID', SetNull, SetNull)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ORDEMITEM', ftInteger)]
    [Dictionary('CTR_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ORDEMITEM: Integer read FCTR_ORDEMITEM write FCTR_ORDEMITEM;
    const CTR_ORDEMITEM_Name = 'CTR_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORNOTAFISCAL: Double read FCTR_VALORNOTAFISCAL write FCTR_VALORNOTAFISCAL;
    const CTR_VALORNOTAFISCAL_Name = 'CTR_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_NUMEROVOLUMES: Double read FCTR_NUMEROVOLUMES write FCTR_NUMEROVOLUMES;
    const CTR_NUMEROVOLUMES_Name = 'CTR_NUMEROVOLUMES';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAALTERACAO: TDateTime read FCTR_DATAALTERACAO write FCTR_DATAALTERACAO;
    const CTR_DATAALTERACAO_Name = 'CTR_DATAALTERACAO';

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
    [Column('CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO: String read FCTR_OBSERVACAO write FCTR_OBSERVACAO;
    const CTR_OBSERVACAO_Name = 'CTR_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOLIQUIDORECEBIMENTO', ftBCD)]
    [Dictionary('CTR_PESOLIQUIDORECEBIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDORECEBIMENTO: Double read FCTR_PESOLIQUIDORECEBIMENTO write FCTR_PESOLIQUIDORECEBIMENTO;
    const CTR_PESOLIQUIDORECEBIMENTO_Name = 'CTR_PESOLIQUIDORECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSO: String read FCTR_CHAVEACESSO write FCTR_CHAVEACESSO;
    const CTR_CHAVEACESSO_Name = 'CTR_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('CTR_BAIXADO', ftString, 1)]
    [Dictionary('CTR_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_BAIXADO: String read FCTR_BAIXADO write FCTR_BAIXADO;
    const CTR_BAIXADO_Name = 'CTR_BAIXADO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROROMANEIO', ftString, 20)]
    [Dictionary('CTR_NUMEROROMANEIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROROMANEIO: String read FCTR_NUMEROROMANEIO write FCTR_NUMEROROMANEIO;
    const CTR_NUMEROROMANEIO_Name = 'CTR_NUMEROROMANEIO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROPEDIDO', ftString, 20)]
    [Dictionary('CTR_NUMEROPEDIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMEROPEDIDO: String read FCTR_NUMEROPEDIDO write FCTR_NUMEROPEDIDO;
    const CTR_NUMEROPEDIDO_Name = 'CTR_NUMEROPEDIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORBASECALCULOICMS', ftBCD)]
    [Dictionary('CTR_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORBASECALCULOICMS: Double read FCTR_VALORBASECALCULOICMS write FCTR_VALORBASECALCULOICMS;
    const CTR_VALORBASECALCULOICMS_Name = 'CTR_VALORBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORBASECALCULOMVA', ftBCD)]
    [Dictionary('CTR_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORBASECALCULOMVA: Double read FCTR_VALORBASECALCULOMVA write FCTR_VALORBASECALCULOMVA;
    const CTR_VALORBASECALCULOMVA_Name = 'CTR_VALORBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('CTR_VALORSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORSUBSTRIBUTARIA: Double read FCTR_VALORSUBSTRIBUTARIA write FCTR_VALORSUBSTRIBUTARIA;
    const CTR_VALORSUBSTRIBUTARIA_Name = 'CTR_VALORSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORPRODUTOS', ftBCD)]
    [Dictionary('CTR_VALORPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORPRODUTOS: Double read FCTR_VALORPRODUTOS write FCTR_VALORPRODUTOS;
    const CTR_VALORPRODUTOS_Name = 'CTR_VALORPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORICMS', ftBCD)]
    [Dictionary('CTR_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORICMS: Double read FCTR_VALORICMS write FCTR_VALORICMS;
    const CTR_VALORICMS_Name = 'CTR_VALORICMS';

    [Restrictions([NoValidate])]
    [Column('CLT_ID', ftInteger)]
    [Dictionary('CLT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLT_ID: Integer read FCLT_ID write FCLT_ID;
    const CLT_ID_Name = 'CLT_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOBRUTO: Double read FCTR_PESOBRUTO write FCTR_PESOBRUTO;
    const CTR_PESOBRUTO_Name = 'CTR_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ETIQUETAIMPRESSA', ftString, 1)]
    [Dictionary('CTR_ETIQUETAIMPRESSA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ETIQUETAIMPRESSA: String read FCTR_ETIQUETAIMPRESSA write FCTR_ETIQUETAIMPRESSA;
    const CTR_ETIQUETAIMPRESSA_Name = 'CTR_ETIQUETAIMPRESSA';

    [Restrictions([NoValidate])]
    [Column('CTR_STATUSBAIXA', ftString, 1)]
    [Dictionary('CTR_STATUSBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_STATUSBAIXA: String read FCTR_STATUSBAIXA write FCTR_STATUSBAIXA;
    const CTR_STATUSBAIXA_Name = 'CTR_STATUSBAIXA';

    [Restrictions([NoValidate])]
    [Column('CTR_01_ID_OLD', ftInteger)]
    [Dictionary('CTR_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_01_ID_OLD: Integer read FCTR_01_ID_OLD write FCTR_01_ID_OLD;
    const CTR_01_ID_OLD_Name = 'CTR_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CLT_ID_OLD', ftInteger)]
    [Dictionary('CLT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLT_ID_OLD: Integer read FCLT_ID_OLD write FCLT_ID_OLD;
    const CLT_ID_OLD_Name = 'CLT_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCTR_00_01)

end.
