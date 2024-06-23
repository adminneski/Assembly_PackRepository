unit express.dbo.XML_NFSE_00;

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
  [Table('XML_NFSE_00', '')]
  [PrimaryKey('XML_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_XML_ID')]
  TDtoXML_NFSE_00 = class
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
    FXML_PROTOCOLOAUTORIZACAO: String;
    FXML_XMLNOTAFISCALCOMAUTORIZACAO: TBlob;
    FXML_XMLAUTORIZACAO: TBlob;
    FXML_PES_CODIGODESTINATARIO: Integer;
    FXML_CPFCNPJDESTINATARIO: String;
    FXML_NOMEDESTINATARIO: String;
    FXML_EMAILDESTINATARIO: String;
    FXML_CSTAT: String;
    FXML_DESCRICAOSTATUS: String;
    FXML_PROTOCOLOCANCELAMENTO: String;
    FXML_MOTIVOCANCELAMENTO: String;
    FXML_XMLCANCELAMENTO: TBlob;
    FXML_IMPRESSO: String;
    FXML_ENVIADOEMAIL: String;
    FXML_STATUS: String;
    FXML_DATAAUTORIZACAO: TDateTime;
    FXML_HORAAUTORIZACAO: String;
    FXML_DATACANCELAMENTO: TDateTime;
    FXML_HORACANCELAMENTO: String;
    FXML_RPS: Integer;
    FXML_INTEGRACAO: String;
    FXML_ID_OLD: Integer;
    FXML_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'XML_NFSE_00';
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
    [Column('XML_VERSAO', ftBCD, 659308878, 2)]
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
    [Column('XML_PROTOCOLOAUTORIZACAO', ftString, 50)]
    [Dictionary('XML_PROTOCOLOAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOAUTORIZACAO: String read FXML_PROTOCOLOAUTORIZACAO write FXML_PROTOCOLOAUTORIZACAO;
    const XML_PROTOCOLOAUTORIZACAO_Name = 'XML_PROTOCOLOAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLNOTAFISCALCOMAUTORIZACAO', ftBlob)]
    [Dictionary('XML_XMLNOTAFISCALCOMAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLNOTAFISCALCOMAUTORIZACAO: TBlob read FXML_XMLNOTAFISCALCOMAUTORIZACAO write FXML_XMLNOTAFISCALCOMAUTORIZACAO;
    const XML_XMLNOTAFISCALCOMAUTORIZACAO_Name = 'XML_XMLNOTAFISCALCOMAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLAUTORIZACAO', ftBlob)]
    [Dictionary('XML_XMLAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLAUTORIZACAO: TBlob read FXML_XMLAUTORIZACAO write FXML_XMLAUTORIZACAO;
    const XML_XMLAUTORIZACAO_Name = 'XML_XMLAUTORIZACAO';

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
    [Column('XML_PROTOCOLOCANCELAMENTO', ftString, 50)]
    [Dictionary('XML_PROTOCOLOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOCANCELAMENTO: String read FXML_PROTOCOLOCANCELAMENTO write FXML_PROTOCOLOCANCELAMENTO;
    const XML_PROTOCOLOCANCELAMENTO_Name = 'XML_PROTOCOLOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_MOTIVOCANCELAMENTO', ftString, 250)]
    [Dictionary('XML_MOTIVOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_MOTIVOCANCELAMENTO: String read FXML_MOTIVOCANCELAMENTO write FXML_MOTIVOCANCELAMENTO;
    const XML_MOTIVOCANCELAMENTO_Name = 'XML_MOTIVOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLCANCELAMENTO', ftBlob)]
    [Dictionary('XML_XMLCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLCANCELAMENTO: TBlob read FXML_XMLCANCELAMENTO write FXML_XMLCANCELAMENTO;
    const XML_XMLCANCELAMENTO_Name = 'XML_XMLCANCELAMENTO';

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
    [Column('XML_STATUS', ftString, 2)]
    [Dictionary('XML_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_STATUS: String read FXML_STATUS write FXML_STATUS;
    const XML_STATUS_Name = 'XML_STATUS';

    [Restrictions([NoValidate])]
    [Column('XML_DATAAUTORIZACAO', ftDateTime)]
    [Dictionary('XML_DATAAUTORIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAAUTORIZACAO: TDateTime read FXML_DATAAUTORIZACAO write FXML_DATAAUTORIZACAO;
    const XML_DATAAUTORIZACAO_Name = 'XML_DATAAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_HORAAUTORIZACAO', ftString, 8)]
    [Dictionary('XML_HORAAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_HORAAUTORIZACAO: String read FXML_HORAAUTORIZACAO write FXML_HORAAUTORIZACAO;
    const XML_HORAAUTORIZACAO_Name = 'XML_HORAAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('XML_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATACANCELAMENTO: TDateTime read FXML_DATACANCELAMENTO write FXML_DATACANCELAMENTO;
    const XML_DATACANCELAMENTO_Name = 'XML_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_HORACANCELAMENTO', ftString, 8)]
    [Dictionary('XML_HORACANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_HORACANCELAMENTO: String read FXML_HORACANCELAMENTO write FXML_HORACANCELAMENTO;
    const XML_HORACANCELAMENTO_Name = 'XML_HORACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_RPS', ftInteger)]
    [Dictionary('XML_RPS', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_RPS: Integer read FXML_RPS write FXML_RPS;
    const XML_RPS_Name = 'XML_RPS';

    [Restrictions([NoValidate])]
    [Column('XML_INTEGRACAO', ftString, 20)]
    [Dictionary('XML_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_INTEGRACAO: String read FXML_INTEGRACAO write FXML_INTEGRACAO;
    const XML_INTEGRACAO_Name = 'XML_INTEGRACAO';

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
  TRegisterClass.RegisterEntity(TDtoXML_NFSE_00)

end.
