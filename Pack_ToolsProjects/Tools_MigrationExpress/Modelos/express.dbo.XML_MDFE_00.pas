unit express.dbo.XML_MDFE_00;

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
  [Table('XML_MDFE_00', '')]
  [PrimaryKey('XML_ID', AutoInc, NoSort, False, 'Chave prim�ria')]
  [Sequence('SEQ_XML_ID')]
  TDtoXML_MDFE_00 = class
  private
    { Private declarations } 
    FXML_ID: Integer;
    FXML_VERSAO: Double;
    FCOM_CODIGO: Integer;
    FXML_CHAVEACESSO: String;
    FXML_NOTAFISCAL: Integer;
    FXML_MODELO: Integer;
    FXML_SERIE: Integer;
    FXML_ANO: Integer;
    FXML_DATAEMISSAO: TDateTime;
    FXML_XMLMANIFESTO: TBlob;
    FXML_XMLMANIFESTOCOMAUTORIZ: TBlob;
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
    FXML_TOMADOR: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FXML_LOTE_MDFE: Integer;
    FXML_PROTOCOLOENCERRAMENTO: String;
    FXML_DATAHORAENCERRAMENTO: TDateTime;
    FXML_XMLENCERRAMENTO: TBlob;
    FXML_INTEGRACAO: String;
    FXML_DATAINUTILIZACAO: TDateTime;
    FXML_HORAINUTILIZACAO: String;
    FXML_DATADPEC: TDateTime;
    FXML_HORADPEC: String;
    FXML_DATAENCERRAMENTO: TDateTime;
    FXML_HORAENCERRAMENTO: String;
    FXML_ID_OLD: Integer;
    FXML_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'XML_MDFE_00';
     const PrimaryKey = 'XML_ID';
     const Sequence   = 'SEQ_XML_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('XML_ID', ftInteger)]
    [Dictionary('XML_ID', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_ID: Integer read FXML_ID write FXML_ID;
    const XML_ID_Name = 'XML_ID';

    [Restrictions([NoValidate])]
    [Column('XML_VERSAO', ftBCD, 996634217, 2)]
    [Dictionary('XML_VERSAO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property XML_VERSAO: Double read FXML_VERSAO write FXML_VERSAO;
    const XML_VERSAO_Name = 'XML_VERSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('XML_CHAVEACESSO', ftString, 44)]
    [Dictionary('XML_CHAVEACESSO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_CHAVEACESSO: String read FXML_CHAVEACESSO write FXML_CHAVEACESSO;
    const XML_CHAVEACESSO_Name = 'XML_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('XML_NOTAFISCAL', ftInteger)]
    [Dictionary('XML_NOTAFISCAL', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_NOTAFISCAL: Integer read FXML_NOTAFISCAL write FXML_NOTAFISCAL;
    const XML_NOTAFISCAL_Name = 'XML_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('XML_MODELO', ftInteger)]
    [Dictionary('XML_MODELO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_MODELO: Integer read FXML_MODELO write FXML_MODELO;
    const XML_MODELO_Name = 'XML_MODELO';

    [Restrictions([NoValidate])]
    [Column('XML_SERIE', ftInteger)]
    [Dictionary('XML_SERIE', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_SERIE: Integer read FXML_SERIE write FXML_SERIE;
    const XML_SERIE_Name = 'XML_SERIE';

    [Restrictions([NoValidate])]
    [Column('XML_ANO', ftInteger)]
    [Dictionary('XML_ANO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_ANO: Integer read FXML_ANO write FXML_ANO;
    const XML_ANO_Name = 'XML_ANO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAEMISSAO', ftDateTime)]
    [Dictionary('XML_DATAEMISSAO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATAEMISSAO: TDateTime read FXML_DATAEMISSAO write FXML_DATAEMISSAO;
    const XML_DATAEMISSAO_Name = 'XML_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLMANIFESTO', ftBlob)]
    [Dictionary('XML_XMLMANIFESTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_XMLMANIFESTO: TBlob read FXML_XMLMANIFESTO write FXML_XMLMANIFESTO;
    const XML_XMLMANIFESTO_Name = 'XML_XMLMANIFESTO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLMANIFESTOCOMAUTORIZ', ftBlob)]
    [Dictionary('XML_XMLMANIFESTOCOMAUTORIZ', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_XMLMANIFESTOCOMAUTORIZ: TBlob read FXML_XMLMANIFESTOCOMAUTORIZ write FXML_XMLMANIFESTOCOMAUTORIZ;
    const XML_XMLMANIFESTOCOMAUTORIZ_Name = 'XML_XMLMANIFESTOCOMAUTORIZ';

    [Restrictions([NoValidate])]
    [Column('XML_CSTAT', ftString, 3)]
    [Dictionary('XML_CSTAT', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_CSTAT: String read FXML_CSTAT write FXML_CSTAT;
    const XML_CSTAT_Name = 'XML_CSTAT';

    [Restrictions([NoValidate])]
    [Column('XML_DESCRICAOSTATUS', ftString, 300)]
    [Dictionary('XML_DESCRICAOSTATUS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_DESCRICAOSTATUS: String read FXML_DESCRICAOSTATUS write FXML_DESCRICAOSTATUS;
    const XML_DESCRICAOSTATUS_Name = 'XML_DESCRICAOSTATUS';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLOINUTILIZACAO', ftString, 50)]
    [Dictionary('XML_PROTOCOLOINUTILIZACAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOINUTILIZACAO: String read FXML_PROTOCOLOINUTILIZACAO write FXML_PROTOCOLOINUTILIZACAO;
    const XML_PROTOCOLOINUTILIZACAO_Name = 'XML_PROTOCOLOINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_MOTIVOINUTILIZACAO', ftString, 250)]
    [Dictionary('XML_MOTIVOINUTILIZACAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_MOTIVOINUTILIZACAO: String read FXML_MOTIVOINUTILIZACAO write FXML_MOTIVOINUTILIZACAO;
    const XML_MOTIVOINUTILIZACAO_Name = 'XML_MOTIVOINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAHORAINUTILIZACAO', ftDateTime)]
    [Dictionary('XML_DATAHORAINUTILIZACAO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATAHORAINUTILIZACAO: TDateTime read FXML_DATAHORAINUTILIZACAO write FXML_DATAHORAINUTILIZACAO;
    const XML_DATAHORAINUTILIZACAO_Name = 'XML_DATAHORAINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLINUTILIZACAO', ftBlob)]
    [Dictionary('XML_XMLINUTILIZACAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_XMLINUTILIZACAO: TBlob read FXML_XMLINUTILIZACAO write FXML_XMLINUTILIZACAO;
    const XML_XMLINUTILIZACAO_Name = 'XML_XMLINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_IMPRESSO', ftString, 1)]
    [Dictionary('XML_IMPRESSO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_IMPRESSO: String read FXML_IMPRESSO write FXML_IMPRESSO;
    const XML_IMPRESSO_Name = 'XML_IMPRESSO';

    [Restrictions([NoValidate])]
    [Column('XML_ENVIADOEMAIL', ftString, 1)]
    [Dictionary('XML_ENVIADOEMAIL', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_ENVIADOEMAIL: String read FXML_ENVIADOEMAIL write FXML_ENVIADOEMAIL;
    const XML_ENVIADOEMAIL_Name = 'XML_ENVIADOEMAIL';

    [Restrictions([NoValidate])]
    [Column('XML_FORMAEMISSAO', ftString, 1)]
    [Dictionary('XML_FORMAEMISSAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_FORMAEMISSAO: String read FXML_FORMAEMISSAO write FXML_FORMAEMISSAO;
    const XML_FORMAEMISSAO_Name = 'XML_FORMAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('XML_STATUS', ftString, 2)]
    [Dictionary('XML_STATUS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_STATUS: String read FXML_STATUS write FXML_STATUS;
    const XML_STATUS_Name = 'XML_STATUS';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLODPEC', ftString, 50)]
    [Dictionary('XML_PROTOCOLODPEC', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_PROTOCOLODPEC: String read FXML_PROTOCOLODPEC write FXML_PROTOCOLODPEC;
    const XML_PROTOCOLODPEC_Name = 'XML_PROTOCOLODPEC';

    [Restrictions([NoValidate])]
    [Column('XML_DATAHORADPEC', ftDateTime)]
    [Dictionary('XML_DATAHORADPEC', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATAHORADPEC: TDateTime read FXML_DATAHORADPEC write FXML_DATAHORADPEC;
    const XML_DATAHORADPEC_Name = 'XML_DATAHORADPEC';

    [Restrictions([NoValidate])]
    [Column('XML_XMLDPEC', ftBlob)]
    [Dictionary('XML_XMLDPEC', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_XMLDPEC: TBlob read FXML_XMLDPEC write FXML_XMLDPEC;
    const XML_XMLDPEC_Name = 'XML_XMLDPEC';

    [Restrictions([NoValidate])]
    [Column('XML_MOTIVOCONTINGENCIA', ftString, 250)]
    [Dictionary('XML_MOTIVOCONTINGENCIA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_MOTIVOCONTINGENCIA: String read FXML_MOTIVOCONTINGENCIA write FXML_MOTIVOCONTINGENCIA;
    const XML_MOTIVOCONTINGENCIA_Name = 'XML_MOTIVOCONTINGENCIA';

    [Restrictions([NoValidate])]
    [Column('XML_TOMADOR', ftInteger)]
    [Dictionary('XML_TOMADOR', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_TOMADOR: Integer read FXML_TOMADOR write FXML_TOMADOR;
    const XML_TOMADOR_Name = 'XML_TOMADOR';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 50)]
    [Dictionary('PES_NOME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('XML_LOTE_MDFE', ftInteger)]
    [Dictionary('XML_LOTE_MDFE', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_LOTE_MDFE: Integer read FXML_LOTE_MDFE write FXML_LOTE_MDFE;
    const XML_LOTE_MDFE_Name = 'XML_LOTE_MDFE';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLOENCERRAMENTO', ftString, 50)]
    [Dictionary('XML_PROTOCOLOENCERRAMENTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOENCERRAMENTO: String read FXML_PROTOCOLOENCERRAMENTO write FXML_PROTOCOLOENCERRAMENTO;
    const XML_PROTOCOLOENCERRAMENTO_Name = 'XML_PROTOCOLOENCERRAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAHORAENCERRAMENTO', ftDateTime)]
    [Dictionary('XML_DATAHORAENCERRAMENTO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATAHORAENCERRAMENTO: TDateTime read FXML_DATAHORAENCERRAMENTO write FXML_DATAHORAENCERRAMENTO;
    const XML_DATAHORAENCERRAMENTO_Name = 'XML_DATAHORAENCERRAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLENCERRAMENTO', ftBlob)]
    [Dictionary('XML_XMLENCERRAMENTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_XMLENCERRAMENTO: TBlob read FXML_XMLENCERRAMENTO write FXML_XMLENCERRAMENTO;
    const XML_XMLENCERRAMENTO_Name = 'XML_XMLENCERRAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_INTEGRACAO', ftString, 20)]
    [Dictionary('XML_INTEGRACAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_INTEGRACAO: String read FXML_INTEGRACAO write FXML_INTEGRACAO;
    const XML_INTEGRACAO_Name = 'XML_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAINUTILIZACAO', ftDateTime)]
    [Dictionary('XML_DATAINUTILIZACAO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATAINUTILIZACAO: TDateTime read FXML_DATAINUTILIZACAO write FXML_DATAINUTILIZACAO;
    const XML_DATAINUTILIZACAO_Name = 'XML_DATAINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_HORAINUTILIZACAO', ftString, 8)]
    [Dictionary('XML_HORAINUTILIZACAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_HORAINUTILIZACAO: String read FXML_HORAINUTILIZACAO write FXML_HORAINUTILIZACAO;
    const XML_HORAINUTILIZACAO_Name = 'XML_HORAINUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('XML_DATADPEC', ftDateTime)]
    [Dictionary('XML_DATADPEC', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATADPEC: TDateTime read FXML_DATADPEC write FXML_DATADPEC;
    const XML_DATADPEC_Name = 'XML_DATADPEC';

    [Restrictions([NoValidate])]
    [Column('XML_HORADPEC', ftString, 8)]
    [Dictionary('XML_HORADPEC', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_HORADPEC: String read FXML_HORADPEC write FXML_HORADPEC;
    const XML_HORADPEC_Name = 'XML_HORADPEC';

    [Restrictions([NoValidate])]
    [Column('XML_DATAENCERRAMENTO', ftDateTime)]
    [Dictionary('XML_DATAENCERRAMENTO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property XML_DATAENCERRAMENTO: TDateTime read FXML_DATAENCERRAMENTO write FXML_DATAENCERRAMENTO;
    const XML_DATAENCERRAMENTO_Name = 'XML_DATAENCERRAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_HORAENCERRAMENTO', ftString, 8)]
    [Dictionary('XML_HORAENCERRAMENTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_HORAENCERRAMENTO: String read FXML_HORAENCERRAMENTO write FXML_HORAENCERRAMENTO;
    const XML_HORAENCERRAMENTO_Name = 'XML_HORAENCERRAMENTO';

    [Restrictions([NoValidate])]
    [Column('XML_ID_OLD', ftInteger)]
    [Dictionary('XML_ID_OLD', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property XML_ID_OLD: Integer read FXML_ID_OLD write FXML_ID_OLD;
    const XML_ID_OLD_Name = 'XML_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('XML_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('XML_INTEGRACAO_OLD', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property XML_INTEGRACAO_OLD: String read FXML_INTEGRACAO_OLD write FXML_INTEGRACAO_OLD;
    const XML_INTEGRACAO_OLD_Name = 'XML_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_MDFE_00)

end.
