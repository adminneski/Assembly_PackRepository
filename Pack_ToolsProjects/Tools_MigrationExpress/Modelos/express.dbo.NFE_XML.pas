unit express.dbo.NFE_XML;

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
  [Table('NFE_XML', '')]
  [PrimaryKey('NFE_XML_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_XML_ID')]
  TDtoNFE_XML = class
  private
    { Private declarations } 
    FNFE_XML_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_NSU: Integer;
    FNFE_NOTAFISCAL: String;
    FNFE_SERIE: String;
    FNFE_CHAVEACESSO: String;
    FNFE_CNPJEMITENTE: String;
    FNFE_RAZAOEMITENTE: String;
    FNFE_IEEMITENTE: String;
    FNFE_DATAEMISSAO: TDateTime;
    FNFE_TIPOOPERACAO: String;
    FNFE_TOTALNOTAFISCAL: Double;
    FNFE_STATUSNFE: String;
    FNFE_STATUSMANIFESTACAO: String;
    FNFE_BAIXADA: String;
    FNFE_IMPORTADA: String;
    FNFE_DATAINCLUSAO: TDateTime;
    FNFE_HORAINCLUSAO: String;
    FNFE_INTEGRACAO: String;
    FNFE_XML_ID_OLD: Integer;
    FNFE_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'NFE_XML';
     const PrimaryKey = 'NFE_XML_ID';
     const Sequence   = 'SEQ_NFE_XML_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_XML_ID', ftInteger)]
    [Dictionary('NFE_XML_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_XML_ID: Integer read FNFE_XML_ID write FNFE_XML_ID;
    const NFE_XML_ID_Name = 'NFE_XML_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_NSU', ftInteger)]
    [Dictionary('NFE_NSU', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_NSU: Integer read FNFE_NSU write FNFE_NSU;
    const NFE_NSU_Name = 'NFE_NSU';

    [Restrictions([NoValidate])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIE', ftString, 3)]
    [Dictionary('NFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIE: String read FNFE_SERIE write FNFE_SERIE;
    const NFE_SERIE_Name = 'NFE_SERIE';

    [Restrictions([NoValidate])]
    [Column('NFE_CHAVEACESSO', ftString, 44)]
    [Dictionary('NFE_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CHAVEACESSO: String read FNFE_CHAVEACESSO write FNFE_CHAVEACESSO;
    const NFE_CHAVEACESSO_Name = 'NFE_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('NFE_CNPJEMITENTE', ftString, 14)]
    [Dictionary('NFE_CNPJEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CNPJEMITENTE: String read FNFE_CNPJEMITENTE write FNFE_CNPJEMITENTE;
    const NFE_CNPJEMITENTE_Name = 'NFE_CNPJEMITENTE';

    [Restrictions([NoValidate])]
    [Column('NFE_RAZAOEMITENTE', ftString, 50)]
    [Dictionary('NFE_RAZAOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_RAZAOEMITENTE: String read FNFE_RAZAOEMITENTE write FNFE_RAZAOEMITENTE;
    const NFE_RAZAOEMITENTE_Name = 'NFE_RAZAOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('NFE_IEEMITENTE', ftString, 16)]
    [Dictionary('NFE_IEEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_IEEMITENTE: String read FNFE_IEEMITENTE write FNFE_IEEMITENTE;
    const NFE_IEEMITENTE_Name = 'NFE_IEEMITENTE';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAEMISSAO', ftDateTime)]
    [Dictionary('NFE_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAEMISSAO: TDateTime read FNFE_DATAEMISSAO write FNFE_DATAEMISSAO;
    const NFE_DATAEMISSAO_Name = 'NFE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPOOPERACAO', ftString, 1)]
    [Dictionary('NFE_TIPOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOOPERACAO: String read FNFE_TIPOOPERACAO write FNFE_TIPOOPERACAO;
    const NFE_TIPOOPERACAO_Name = 'NFE_TIPOOPERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALNOTAFISCAL: Double read FNFE_TOTALNOTAFISCAL write FNFE_TOTALNOTAFISCAL;
    const NFE_TOTALNOTAFISCAL_Name = 'NFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_STATUSNFE', ftString, 1)]
    [Dictionary('NFE_STATUSNFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_STATUSNFE: String read FNFE_STATUSNFE write FNFE_STATUSNFE;
    const NFE_STATUSNFE_Name = 'NFE_STATUSNFE';

    [Restrictions([NoValidate])]
    [Column('NFE_STATUSMANIFESTACAO', ftString, 1)]
    [Dictionary('NFE_STATUSMANIFESTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_STATUSMANIFESTACAO: String read FNFE_STATUSMANIFESTACAO write FNFE_STATUSMANIFESTACAO;
    const NFE_STATUSMANIFESTACAO_Name = 'NFE_STATUSMANIFESTACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_BAIXADA', ftString, 1)]
    [Dictionary('NFE_BAIXADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_BAIXADA: String read FNFE_BAIXADA write FNFE_BAIXADA;
    const NFE_BAIXADA_Name = 'NFE_BAIXADA';

    [Restrictions([NoValidate])]
    [Column('NFE_IMPORTADA', ftString, 1)]
    [Dictionary('NFE_IMPORTADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_IMPORTADA: String read FNFE_IMPORTADA write FNFE_IMPORTADA;
    const NFE_IMPORTADA_Name = 'NFE_IMPORTADA';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAINCLUSAO', ftDateTime)]
    [Dictionary('NFE_DATAINCLUSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAINCLUSAO: TDateTime read FNFE_DATAINCLUSAO write FNFE_DATAINCLUSAO;
    const NFE_DATAINCLUSAO_Name = 'NFE_DATAINCLUSAO';

    [Restrictions([NoValidate])]
    [Column('NFE_HORAINCLUSAO', ftString, 8)]
    [Dictionary('NFE_HORAINCLUSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_HORAINCLUSAO: String read FNFE_HORAINCLUSAO write FNFE_HORAINCLUSAO;
    const NFE_HORAINCLUSAO_Name = 'NFE_HORAINCLUSAO';

    [Restrictions([NoValidate])]
    [Column('NFE_INTEGRACAO', ftString, 20)]
    [Dictionary('NFE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_INTEGRACAO: String read FNFE_INTEGRACAO write FNFE_INTEGRACAO;
    const NFE_INTEGRACAO_Name = 'NFE_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_XML_ID_OLD', ftInteger)]
    [Dictionary('NFE_XML_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_XML_ID_OLD: Integer read FNFE_XML_ID_OLD write FNFE_XML_ID_OLD;
    const NFE_XML_ID_OLD_Name = 'NFE_XML_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('NFE_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_INTEGRACAO_OLD: String read FNFE_INTEGRACAO_OLD write FNFE_INTEGRACAO_OLD;
    const NFE_INTEGRACAO_OLD_Name = 'NFE_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_XML)

end.
