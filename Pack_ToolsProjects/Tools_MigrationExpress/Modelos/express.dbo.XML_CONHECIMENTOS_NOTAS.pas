unit express.dbo.XML_CONHECIMENTOS_NOTAS;

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
  [Table('XML_CONHECIMENTOS_NOTAS', '')]
  TDtoXML_CONHECIMENTOS_NOTAS = class
  private
    { Private declarations } 
    FCT_TIPO: String;
    FCT_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCT_ID: Integer;
    FCT_SERIE: String;
    FMNF_CODIGO: String;
    FCT_DATAEMISSAO: TDateTime;
    FCT_ORDEMITEM: Integer;
    FCT_NOTAFISCAL: String;
    FCT_VALORNOTAFISCAL: Double;
    FCT_NUMEROVOLUMES: Double;
    FCT_VALORSEMIPI: Double;
    FCT_VALORCOMIPI: Double;
    FCT_PESOLIQUIDO: Double;
    FCT_PESOBRUTO: Double;
    FCT_CHAVEACESSO: String;
    FCT_VALORBASECALCULOICMS: Double;
    FCT_VALORBASECALCULOMVA: Double;
    FCT_VALORSUBSTRIBUTARIA: Double;
    FCT_VALORPRODUTOS: Double;
    FCFOP_CODIGO: String;
    FCT_VALORICMS: Double;
    FCT_NUMEROROMANEIO: String;
    FCT_NUMEROPEDIDO: String;
    FCT_NUMERODOCTO: String;
    FCT_DESCRICAODOCTO: String;
    FCT_VALORDOCTO: Double;
    FCT_DATAPREVISAOENTREGA: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'XML_CONHECIMENTOS_NOTAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_TIPO', ftString, 2)]
    [Dictionary('CT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_TIPO: String read FCT_TIPO write FCT_TIPO;
    const CT_TIPO_Name = 'CT_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_01_ID', ftInteger)]
    [Dictionary('CT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CT_01_ID: Integer read FCT_01_ID write FCT_01_ID;
    const CT_01_ID_Name = 'CT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CT_ID', ftInteger)]
    [Dictionary('CT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CT_ID: Integer read FCT_ID write FCT_ID;
    const CT_ID_Name = 'CT_ID';

    [Restrictions([NoValidate])]
    [Column('CT_SERIE', ftString, 3)]
    [Dictionary('CT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_SERIE: String read FCT_SERIE write FCT_SERIE;
    const CT_SERIE_Name = 'CT_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CT_DATAEMISSAO', ftDateTime)]
    [Dictionary('CT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CT_DATAEMISSAO: TDateTime read FCT_DATAEMISSAO write FCT_DATAEMISSAO;
    const CT_DATAEMISSAO_Name = 'CT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CT_ORDEMITEM', ftInteger)]
    [Dictionary('CT_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CT_ORDEMITEM: Integer read FCT_ORDEMITEM write FCT_ORDEMITEM;
    const CT_ORDEMITEM_Name = 'CT_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CT_NOTAFISCAL', ftString, 9)]
    [Dictionary('CT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NOTAFISCAL: String read FCT_NOTAFISCAL write FCT_NOTAFISCAL;
    const CT_NOTAFISCAL_Name = 'CT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CT_VALORNOTAFISCAL', ftBCD, 539780974, 2)]
    [Dictionary('CT_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORNOTAFISCAL: Double read FCT_VALORNOTAFISCAL write FCT_VALORNOTAFISCAL;
    const CT_VALORNOTAFISCAL_Name = 'CT_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CT_NUMEROVOLUMES', ftBCD, 1415532614, 3)]
    [Dictionary('CT_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_NUMEROVOLUMES: Double read FCT_NUMEROVOLUMES write FCT_NUMEROVOLUMES;
    const CT_NUMEROVOLUMES_Name = 'CT_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CT_VALORSEMIPI', ftBCD, 1599096398, 2)]
    [Dictionary('CT_VALORSEMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORSEMIPI: Double read FCT_VALORSEMIPI write FCT_VALORSEMIPI;
    const CT_VALORSEMIPI_Name = 'CT_VALORSEMIPI';

    [Restrictions([NoValidate])]
    [Column('CT_VALORCOMIPI', ftBCD, 1142962771, 2)]
    [Dictionary('CT_VALORCOMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORCOMIPI: Double read FCT_VALORCOMIPI write FCT_VALORCOMIPI;
    const CT_VALORCOMIPI_Name = 'CT_VALORCOMIPI';

    [Restrictions([NoValidate])]
    [Column('CT_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CT_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_PESOLIQUIDO: Double read FCT_PESOLIQUIDO write FCT_PESOLIQUIDO;
    const CT_PESOLIQUIDO_Name = 'CT_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CT_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CT_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_PESOBRUTO: Double read FCT_PESOBRUTO write FCT_PESOBRUTO;
    const CT_PESOBRUTO_Name = 'CT_PESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('CT_CHAVEACESSO', ftString, 44)]
    [Dictionary('CT_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_CHAVEACESSO: String read FCT_CHAVEACESSO write FCT_CHAVEACESSO;
    const CT_CHAVEACESSO_Name = 'CT_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('CT_VALORBASECALCULOICMS', ftBCD, 1702129225, 2)]
    [Dictionary('CT_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORBASECALCULOICMS: Double read FCT_VALORBASECALCULOICMS write FCT_VALORBASECALCULOICMS;
    const CT_VALORBASECALCULOICMS_Name = 'CT_VALORBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('CT_VALORBASECALCULOMVA', ftBCD, 1936020059, 2)]
    [Dictionary('CT_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORBASECALCULOMVA: Double read FCT_VALORBASECALCULOMVA write FCT_VALORBASECALCULOMVA;
    const CT_VALORBASECALCULOMVA_Name = 'CT_VALORBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('CT_VALORSUBSTRIBUTARIA', ftBCD, 2097196, 2)]
    [Dictionary('CT_VALORSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORSUBSTRIBUTARIA: Double read FCT_VALORSUBSTRIBUTARIA write FCT_VALORSUBSTRIBUTARIA;
    const CT_VALORSUBSTRIBUTARIA_Name = 'CT_VALORSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('CT_VALORPRODUTOS', ftBCD, 1818453348, 2)]
    [Dictionary('CT_VALORPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORPRODUTOS: Double read FCT_VALORPRODUTOS write FCT_VALORPRODUTOS;
    const CT_VALORPRODUTOS_Name = 'CT_VALORPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CT_VALORICMS', ftBCD, 221996910, 2)]
    [Dictionary('CT_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORICMS: Double read FCT_VALORICMS write FCT_VALORICMS;
    const CT_VALORICMS_Name = 'CT_VALORICMS';

    [Restrictions([NoValidate])]
    [Column('CT_NUMEROROMANEIO', ftString, 20)]
    [Dictionary('CT_NUMEROROMANEIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NUMEROROMANEIO: String read FCT_NUMEROROMANEIO write FCT_NUMEROROMANEIO;
    const CT_NUMEROROMANEIO_Name = 'CT_NUMEROROMANEIO';

    [Restrictions([NoValidate])]
    [Column('CT_NUMEROPEDIDO', ftString, 20)]
    [Dictionary('CT_NUMEROPEDIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NUMEROPEDIDO: String read FCT_NUMEROPEDIDO write FCT_NUMEROPEDIDO;
    const CT_NUMEROPEDIDO_Name = 'CT_NUMEROPEDIDO';

    [Restrictions([NoValidate])]
    [Column('CT_NUMERODOCTO', ftString, 100)]
    [Dictionary('CT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_NUMERODOCTO: String read FCT_NUMERODOCTO write FCT_NUMERODOCTO;
    const CT_NUMERODOCTO_Name = 'CT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CT_DESCRICAODOCTO', ftString, 20)]
    [Dictionary('CT_DESCRICAODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CT_DESCRICAODOCTO: String read FCT_DESCRICAODOCTO write FCT_DESCRICAODOCTO;
    const CT_DESCRICAODOCTO_Name = 'CT_DESCRICAODOCTO';

    [Restrictions([NoValidate])]
    [Column('CT_VALORDOCTO', ftBCD, 1179206738, 2)]
    [Dictionary('CT_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CT_VALORDOCTO: Double read FCT_VALORDOCTO write FCT_VALORDOCTO;
    const CT_VALORDOCTO_Name = 'CT_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('CT_DATAPREVISAOENTREGA', ftDateTime)]
    [Dictionary('CT_DATAPREVISAOENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CT_DATAPREVISAOENTREGA: TDateTime read FCT_DATAPREVISAOENTREGA write FCT_DATAPREVISAOENTREGA;
    const CT_DATAPREVISAOENTREGA_Name = 'CT_DATAPREVISAOENTREGA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_CONHECIMENTOS_NOTAS)

end.
