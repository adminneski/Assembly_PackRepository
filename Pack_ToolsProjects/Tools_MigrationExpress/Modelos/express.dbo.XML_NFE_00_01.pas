unit express.dbo.XML_NFE_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.xml_nfe_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('XML_NFE_00_01', '')]
  [PrimaryKey('XML_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_XML_01_ID')]
  TDtoXML_NFE_00_01 = class
  private
    { Private declarations } 
    FXML_01_ID: Integer;
    FXML_ID: Integer;
    FCOM_CODIGO: Integer;
    FXML_CHAVEACESSO: String;
    FXML_SEQUENCIAEVENTO: Integer;
    FXML_TIPOEVENTO: String;
    FXML_DATAHORAEVENTO: TDateTime;
    FXML_PROTOCOLOEVENTO: String;
    FXML_MOTIVOEVENTO: String;
    FXML_XMLEVENTO: TBlob;
    FXML_DATAEVENTO: TDateTime;
    FXML_HORAEVENTO: String;
    FXML_01_ID_OLD: Integer;
    FXML_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'XML_NFE_00_01';
    const PrimaryKey = 'XML_01_ID';
    const Sequence   = 'SEQ_XML_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('XML_01_ID', ftInteger)]
    [Dictionary('XML_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_01_ID: Integer read FXML_01_ID write FXML_01_ID;
    const XML_01_ID_Name = 'XML_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('XML_ID', ftInteger)]
    [ForeignKey('XML_NFE_00_01_fk', 'XML_ID', 'XML_NFE_00', 'XML_ID', SetNull, SetNull)]
    [Dictionary('XML_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_ID: Integer read FXML_ID write FXML_ID;
    const XML_ID_Name = 'XML_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('XML_CHAVEACESSO', ftString, 44)]
    [Dictionary('XML_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_CHAVEACESSO: String read FXML_CHAVEACESSO write FXML_CHAVEACESSO;
    const XML_CHAVEACESSO_Name = 'XML_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('XML_SEQUENCIAEVENTO', ftInteger)]
    [Dictionary('XML_SEQUENCIAEVENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_SEQUENCIAEVENTO: Integer read FXML_SEQUENCIAEVENTO write FXML_SEQUENCIAEVENTO;
    const XML_SEQUENCIAEVENTO_Name = 'XML_SEQUENCIAEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_TIPOEVENTO', ftString, 3)]
    [Dictionary('XML_TIPOEVENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_TIPOEVENTO: String read FXML_TIPOEVENTO write FXML_TIPOEVENTO;
    const XML_TIPOEVENTO_Name = 'XML_TIPOEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAHORAEVENTO', ftDateTime)]
    [Dictionary('XML_DATAHORAEVENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAHORAEVENTO: TDateTime read FXML_DATAHORAEVENTO write FXML_DATAHORAEVENTO;
    const XML_DATAHORAEVENTO_Name = 'XML_DATAHORAEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_PROTOCOLOEVENTO', ftString, 50)]
    [Dictionary('XML_PROTOCOLOEVENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_PROTOCOLOEVENTO: String read FXML_PROTOCOLOEVENTO write FXML_PROTOCOLOEVENTO;
    const XML_PROTOCOLOEVENTO_Name = 'XML_PROTOCOLOEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_MOTIVOEVENTO', ftString, 1000)]
    [Dictionary('XML_MOTIVOEVENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_MOTIVOEVENTO: String read FXML_MOTIVOEVENTO write FXML_MOTIVOEVENTO;
    const XML_MOTIVOEVENTO_Name = 'XML_MOTIVOEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_XMLEVENTO', ftBlob)]
    [Dictionary('XML_XMLEVENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_XMLEVENTO: TBlob read FXML_XMLEVENTO write FXML_XMLEVENTO;
    const XML_XMLEVENTO_Name = 'XML_XMLEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_DATAEVENTO', ftDateTime)]
    [Dictionary('XML_DATAEVENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property XML_DATAEVENTO: TDateTime read FXML_DATAEVENTO write FXML_DATAEVENTO;
    const XML_DATAEVENTO_Name = 'XML_DATAEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_HORAEVENTO', ftString, 8)]
    [Dictionary('XML_HORAEVENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XML_HORAEVENTO: String read FXML_HORAEVENTO write FXML_HORAEVENTO;
    const XML_HORAEVENTO_Name = 'XML_HORAEVENTO';

    [Restrictions([NoValidate])]
    [Column('XML_01_ID_OLD', ftInteger)]
    [Dictionary('XML_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_01_ID_OLD: Integer read FXML_01_ID_OLD write FXML_01_ID_OLD;
    const XML_01_ID_OLD_Name = 'XML_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('XML_ID_OLD', ftInteger)]
    [Dictionary('XML_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property XML_ID_OLD: Integer read FXML_ID_OLD write FXML_ID_OLD;
    const XML_ID_OLD_Name = 'XML_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_NFE_00_01)

end.
