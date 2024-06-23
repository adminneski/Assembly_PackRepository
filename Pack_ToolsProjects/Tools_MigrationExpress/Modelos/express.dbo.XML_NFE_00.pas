unit express.dbo.XML_NFE_00;

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
  [Table('XML_NFE_00', '')]
  [PrimaryKey('XML_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_XML_ID')]
  TDtoXML_NFE_00 = class
  private
    { Private declarations } 
    FXML_ID: Integer;
    FXML_CHAVEACESSO: String;
    FCOM_CODIGO: Integer;
    FXML_VERSAO: Double;
    FXML_LOTE: Integer;
    FXML_TIPO: String;
    FXML_NOTAFISCAL: Integer;
    FXML_MODELO: Integer;
    FXML_SERIE: Integer;
    FXML_ANO: Integer;
    FXML_DATAEMISSAO: TDateTime;
    FXML_XMLNOTAFISCAL: TBlob;
    FXML_XMLNOTAFISCALCOMAUTORIZACAO: TBlob;
    FXML_PES_CODIGODESTINATARIO: Integer;
    FXML_CPFCNPJDESTINATARIO: String;
    FXML_NOMEDESTINATARIO: String;
    FXML_EMAILDESTINATARIO: String;
    FXML_CSTAT: String;
    FXML_DESCRICAOSTATUS: String;
    FXML_PROTOCOLOINUTILIZACAO: String;
    FXML_MOTIVOINUTILIZACAO: String;
    FXML_DATAHORAINUTILIZACAO: TDateTime;
    FXML_XMLINUTILIZACAO: TBlob;
    FXML_IMPRESSO: String;
    FXML_ENVIADOEMAIL: String;
    FXML_FORMAEMISSAO: String;
    FXML_STATUS: String;
    FXML_PROTOCOLODPEC: String;
    FXML_DATAHORADPEC: TDateTime;
    FXML_XMLDPEC: TBlob;
    FXML_MOTIVOCONTINGENCIA: String;
    FXML_XMLCARTACORRECAO: TBlob;
    FXML_XMLAUTORIZACAOCCE: TBlob;
    FXML_CSTATCCE: String;
    FXML_CORRECOESCCE: String;
    FXML_PROTOCOLOCCE: String;
    FXML_INTEGRACAO: String;
    FXML_DATAINUTILIZACAO: TDateTime;
    FXML_HORAINUTILIZACAO: String;
    FXML_DATADPEC: TDateTime;
    FXML_HORADPEC: String;
    FXML_ID_OLD: Integer;
    FXML_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'XML_NFE_00';
     const PrimaryKey = 'XML_ID';
     const Sequence   = 'SEQ_XML_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('XML_ID', ftInteger)]
    [Dictionary('XML_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_ID: Integer read FXML_ID write FXML_ID;
    const XML_ID_Name = 'XML_ID';

    [Restrictions([NoValidate])]
    [Column('XML_CHAVEACESSO', ftString, 44)]
    [Dictionary('XML_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_CHAVEACESSO: String read FXML_CHAVEACESSO write FXML_CHAVEACESSO;
    const XML_CHAVEACESSO_Name = 'XML_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('XML_VERSAO', ftBCD, 1598243924, 2)]
    [Dictionary('XML_VERSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property XML_VERSAO: Double read FXML_VERSAO write FXML_VERSAO;
    const XML_VERSAO_Name = 'XML_VERSAO';

    [Restrictions([NoValidate])]
    [Column('XML_LOTE', ftInteger)]
    [Dictionary('XML_LOTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_LOTE: Integer read FXML_LOTE write FXML_LOTE;
    const XML_LOTE_Name = 'XML_LOTE';

    [Restrictions([NoValidate])]
    [Column('XML_TIPO', ftString, 3)]
    [Dictionary('XML_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_TIPO: String read FXML_TIPO write FXML_TIPO;
    const XML_TIPO_Name = 'XML_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('XML_NOTAFISCAL', ftInteger)]
    [Dictionary('XML_NOTAFISCAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_NOTAFISCAL: Integer read FXML_NOTAFISCAL write FXML_NOTAFISCAL;
    const XML_NOTAFISCAL_Name = 'XML_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('XML_MODELO', ftInteger)]
    [Dictionary('XML_MODELO', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_MODELO: Integer read FXML_MODELO write FXML_MODELO;
    const XML_MODELO_Name = 'XML_MODELO';

    [Restrictions([NoValidate])]
    [Column('XML_SERIE', ftInteger)]
    [Dictionary('XML_SERIE', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_SERIE: Integer read FXML_SERIE write FXML_SERIE;
    const XML_SERIE_Name = 'XML_SERIE';

    [Restrictions([NoValidate])]
    [Column('XML_ANO', ftInteger)]
    [Dictionary('XML_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_ANO: Integer read FXML_ANO write FXML_ANO;
    const XML_ANO_Name = 'XML_ANO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAEMISSAO', ftDateTime)]
    [Dictionary('XML_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAEMISSAO: TDateTime read FXML_DATAEMISSAO write FXML_DATAEMISSAO;
    const XML_DATAEMISSAO_Name = 'XML_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLNOTAFISCAL', ftBlob)]
    [Dictionary('XML_XMLNOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLNOTAFISCAL: TBlob read FXML_XMLNOTAFISCAL write FXML_XMLNOTAFISCAL;
    const XML_XMLNOTAFISCAL_Name = 'XML_XMLNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('XML_XMLNOTAFISCALCOMAUTORIZACAO', ftBlob)]
    [Dictionary('XML_XMLNOTAFISCALCOMAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLNOTAFISCALCOMAUTORIZACAO: TBlob read FXML_XMLNOTAFISCALCOMAUTORIZACAO write FXML_XMLNOTAFISCALCOMAUTORIZACAO;
    const XML_XMLNOTAFISCALCOMAUTORIZACAO_Name = 'XML_XMLNOTAFISCALCOMAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_PES_CODIGODESTINATARIO', ftInteger)]
    [Dictionary('XML_PES_CODIGODESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_PES_CODIGODESTINATARIO: Integer read FXML_PES_CODIGODESTINATARIO write FXML_PES_CODIGODESTINATARIO;
    const XML_PES_CODIGODESTINATARIO_Name = 'XML_PES_CODIGODESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('XML_CPFCNPJDESTINATARIO', ftString, 14)]
    [Dictionary('XML_CPFCNPJDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_CPFCNPJDESTINATARIO: String read FXML_CPFCNPJDESTINATARIO write FXML_CPFCNPJDESTINATARIO;
    const XML_CPFCNPJDESTINATARIO_Name = 'XML_CPFCNPJDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('XML_NOMEDESTINATARIO', ftString, 100)]
    [Dictionary('XML_NOMEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_NOMEDESTINATARIO: String read FXML_NOMEDESTINATARIO write FXML_NOMEDESTINATARIO;
    const XML_NOMEDESTINATARIO_Name = 'XML_NOMEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('XML_EMAILDESTINATARIO', ftString, 300)]
    [Dictionary('XML_EMAILDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_EMAILDESTINATARIO: String read FXML_EMAILDESTINATARIO write FXML_EMAILDESTINATARIO;
    const XML_EMAILDESTINATARIO_Name = 'XML_EMAILDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('XML_CSTAT', ftString, 3)]
    [Dictionary('XML_CSTAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_CSTAT: String read FXML_CSTAT write FXML_CSTAT;
    const XML_CSTAT_Name = 'XML_CSTAT';

    [Restrictions([NoValidate])]
    [Column('XML_DESCRICAOSTATUS', ftString, 3000)]
    [Dictionary('XML_DESCRICAOSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_DESCRICAOSTATUS: String read FXML_DESCRICAOSTATUS write FXML_DESCRICAOSTATUS;
    const XML_DESCRICAOSTATUS_Name = 'XML_DESCRICAOSTATUS';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLOINUTILIZACAO', ftString, 50)]
    [Dictionary('XML_PROTOCOLOINUTILIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOINUTILIZACAO: String read FXML_PROTOCOLOINUTILIZACAO write FXML_PROTOCOLOINUTILIZACAO;
    const XML_PROTOCOLOINUTILIZACAO_Name = 'XML_PROTOCOLOINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_MOTIVOINUTILIZACAO', ftString, 250)]
    [Dictionary('XML_MOTIVOINUTILIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_MOTIVOINUTILIZACAO: String read FXML_MOTIVOINUTILIZACAO write FXML_MOTIVOINUTILIZACAO;
    const XML_MOTIVOINUTILIZACAO_Name = 'XML_MOTIVOINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAHORAINUTILIZACAO', ftDateTime)]
    [Dictionary('XML_DATAHORAINUTILIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAHORAINUTILIZACAO: TDateTime read FXML_DATAHORAINUTILIZACAO write FXML_DATAHORAINUTILIZACAO;
    const XML_DATAHORAINUTILIZACAO_Name = 'XML_DATAHORAINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLINUTILIZACAO', ftBlob)]
    [Dictionary('XML_XMLINUTILIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLINUTILIZACAO: TBlob read FXML_XMLINUTILIZACAO write FXML_XMLINUTILIZACAO;
    const XML_XMLINUTILIZACAO_Name = 'XML_XMLINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_IMPRESSO', ftString, 1)]
    [Dictionary('XML_IMPRESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_IMPRESSO: String read FXML_IMPRESSO write FXML_IMPRESSO;
    const XML_IMPRESSO_Name = 'XML_IMPRESSO';

    [Restrictions([NoValidate])]
    [Column('XML_ENVIADOEMAIL', ftString, 1)]
    [Dictionary('XML_ENVIADOEMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_ENVIADOEMAIL: String read FXML_ENVIADOEMAIL write FXML_ENVIADOEMAIL;
    const XML_ENVIADOEMAIL_Name = 'XML_ENVIADOEMAIL';

    [Restrictions([NoValidate])]
    [Column('XML_FORMAEMISSAO', ftString, 1)]
    [Dictionary('XML_FORMAEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_FORMAEMISSAO: String read FXML_FORMAEMISSAO write FXML_FORMAEMISSAO;
    const XML_FORMAEMISSAO_Name = 'XML_FORMAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('XML_STATUS', ftString, 2)]
    [Dictionary('XML_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_STATUS: String read FXML_STATUS write FXML_STATUS;
    const XML_STATUS_Name = 'XML_STATUS';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLODPEC', ftString, 50)]
    [Dictionary('XML_PROTOCOLODPEC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_PROTOCOLODPEC: String read FXML_PROTOCOLODPEC write FXML_PROTOCOLODPEC;
    const XML_PROTOCOLODPEC_Name = 'XML_PROTOCOLODPEC';

    [Restrictions([NoValidate])]
    [Column('XML_DATAHORADPEC', ftDateTime)]
    [Dictionary('XML_DATAHORADPEC', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAHORADPEC: TDateTime read FXML_DATAHORADPEC write FXML_DATAHORADPEC;
    const XML_DATAHORADPEC_Name = 'XML_DATAHORADPEC';

    [Restrictions([NoValidate])]
    [Column('XML_XMLDPEC', ftBlob)]
    [Dictionary('XML_XMLDPEC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLDPEC: TBlob read FXML_XMLDPEC write FXML_XMLDPEC;
    const XML_XMLDPEC_Name = 'XML_XMLDPEC';

    [Restrictions([NoValidate])]
    [Column('XML_MOTIVOCONTINGENCIA', ftString, 250)]
    [Dictionary('XML_MOTIVOCONTINGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_MOTIVOCONTINGENCIA: String read FXML_MOTIVOCONTINGENCIA write FXML_MOTIVOCONTINGENCIA;
    const XML_MOTIVOCONTINGENCIA_Name = 'XML_MOTIVOCONTINGENCIA';

    [Restrictions([NoValidate])]
    [Column('XML_XMLCARTACORRECAO', ftBlob)]
    [Dictionary('XML_XMLCARTACORRECAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLCARTACORRECAO: TBlob read FXML_XMLCARTACORRECAO write FXML_XMLCARTACORRECAO;
    const XML_XMLCARTACORRECAO_Name = 'XML_XMLCARTACORRECAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLAUTORIZACAOCCE', ftBlob)]
    [Dictionary('XML_XMLAUTORIZACAOCCE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLAUTORIZACAOCCE: TBlob read FXML_XMLAUTORIZACAOCCE write FXML_XMLAUTORIZACAOCCE;
    const XML_XMLAUTORIZACAOCCE_Name = 'XML_XMLAUTORIZACAOCCE';

    [Restrictions([NoValidate])]
    [Column('XML_CSTATCCE', ftString, 3)]
    [Dictionary('XML_CSTATCCE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_CSTATCCE: String read FXML_CSTATCCE write FXML_CSTATCCE;
    const XML_CSTATCCE_Name = 'XML_CSTATCCE';

    [Restrictions([NoValidate])]
    [Column('XML_CORRECOESCCE', ftString, 5000)]
    [Dictionary('XML_CORRECOESCCE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_CORRECOESCCE: String read FXML_CORRECOESCCE write FXML_CORRECOESCCE;
    const XML_CORRECOESCCE_Name = 'XML_CORRECOESCCE';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLOCCE', ftString, 50)]
    [Dictionary('XML_PROTOCOLOCCE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOCCE: String read FXML_PROTOCOLOCCE write FXML_PROTOCOLOCCE;
    const XML_PROTOCOLOCCE_Name = 'XML_PROTOCOLOCCE';

    [Restrictions([NoValidate])]
    [Column('XML_INTEGRACAO', ftString, 20)]
    [Dictionary('XML_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_INTEGRACAO: String read FXML_INTEGRACAO write FXML_INTEGRACAO;
    const XML_INTEGRACAO_Name = 'XML_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAINUTILIZACAO', ftDateTime)]
    [Dictionary('XML_DATAINUTILIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAINUTILIZACAO: TDateTime read FXML_DATAINUTILIZACAO write FXML_DATAINUTILIZACAO;
    const XML_DATAINUTILIZACAO_Name = 'XML_DATAINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_HORAINUTILIZACAO', ftString, 8)]
    [Dictionary('XML_HORAINUTILIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_HORAINUTILIZACAO: String read FXML_HORAINUTILIZACAO write FXML_HORAINUTILIZACAO;
    const XML_HORAINUTILIZACAO_Name = 'XML_HORAINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATADPEC', ftDateTime)]
    [Dictionary('XML_DATADPEC', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATADPEC: TDateTime read FXML_DATADPEC write FXML_DATADPEC;
    const XML_DATADPEC_Name = 'XML_DATADPEC';

    [Restrictions([NoValidate])]
    [Column('XML_HORADPEC', ftString, 8)]
    [Dictionary('XML_HORADPEC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_HORADPEC: String read FXML_HORADPEC write FXML_HORADPEC;
    const XML_HORADPEC_Name = 'XML_HORADPEC';

    [Restrictions([NoValidate])]
    [Column('XML_ID_OLD', ftInteger)]
    [Dictionary('XML_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_ID_OLD: Integer read FXML_ID_OLD write FXML_ID_OLD;
    const XML_ID_OLD_Name = 'XML_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('XML_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('XML_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_INTEGRACAO_OLD: String read FXML_INTEGRACAO_OLD write FXML_INTEGRACAO_OLD;
    const XML_INTEGRACAO_OLD_Name = 'XML_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_NFE_00)

end.
