unit express.dbo.XML_MANIFESTOCARGA_NOTAS;

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
  [Table('XML_MANIFESTOCARGA_NOTAS', '')]
  TDtoXML_MANIFESTOCARGA_NOTAS = class
  private
    { Private declarations } 
    FMF_TIPODOCTO: String;
    FCOM_CODIGO: Integer;
    FMF_ID: Integer;
    FCTR_ID: Integer;
    FMNF_CODIGO: String;
    FMF_ORDEMITEM: Integer;
    FCTR_NOTAFISCAL: String;
    FCTR_NUMERODOCTO: String;
    FMF_TIPOFRETE: String;
    FMF_VALORFRETE: Double;
    FMF_VALORNOTAFISCAL: Double;
    FMF_CODIGORASTREAMENTO: String;
    FMF_PESOBRUTO: Double;
    FCID_IBGE: String;
    FMF_CIDADE: String;
    FCTR_CHAVEACESSO: String;
    FMF_UF: String;
    FCID_IBGEORIGEM: Integer;
    FMF_CIDADEORIGEM: String;
  public 
    { Public declarations } 
     const Table      = 'XML_MANIFESTOCARGA_NOTAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TIPODOCTO', ftString, 3)]
    [Dictionary('MF_TIPODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_TIPODOCTO: String read FMF_TIPODOCTO write FMF_TIPODOCTO;
    const MF_TIPODOCTO_Name = 'MF_TIPODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_ID', ftInteger)]
    [Dictionary('MF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MF_ID: Integer read FMF_ID write FMF_ID;
    const MF_ID_Name = 'MF_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_ORDEMITEM', ftInteger)]
    [Dictionary('MF_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property MF_ORDEMITEM: Integer read FMF_ORDEMITEM write FMF_ORDEMITEM;
    const MF_ORDEMITEM_Name = 'MF_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('MF_TIPOFRETE', ftString, 1)]
    [Dictionary('MF_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_TIPOFRETE: String read FMF_TIPOFRETE write FMF_TIPOFRETE;
    const MF_TIPOFRETE_Name = 'MF_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_VALORFRETE', ftBCD)]
    [Dictionary('MF_VALORFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_VALORFRETE: Double read FMF_VALORFRETE write FMF_VALORFRETE;
    const MF_VALORFRETE_Name = 'MF_VALORFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('MF_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_VALORNOTAFISCAL: Double read FMF_VALORNOTAFISCAL write FMF_VALORNOTAFISCAL;
    const MF_VALORNOTAFISCAL_Name = 'MF_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MF_CODIGORASTREAMENTO', ftString, 20)]
    [Dictionary('MF_CODIGORASTREAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_CODIGORASTREAMENTO: String read FMF_CODIGORASTREAMENTO write FMF_CODIGORASTREAMENTO;
    const MF_CODIGORASTREAMENTO_Name = 'MF_CODIGORASTREAMENTO';

    [Restrictions([NoValidate])]
    [Column('MF_PESOBRUTO', ftBCD)]
    [Dictionary('MF_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_PESOBRUTO: Double read FMF_PESOBRUTO write FMF_PESOBRUTO;
    const MF_PESOBRUTO_Name = 'MF_PESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('MF_CIDADE', ftString, 100)]
    [Dictionary('MF_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_CIDADE: String read FMF_CIDADE write FMF_CIDADE;
    const MF_CIDADE_Name = 'MF_CIDADE';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSO: String read FCTR_CHAVEACESSO write FCTR_CHAVEACESSO;
    const CTR_CHAVEACESSO_Name = 'CTR_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('MF_UF', ftString, 2)]
    [Dictionary('MF_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_UF: String read FMF_UF write FMF_UF;
    const MF_UF_Name = 'MF_UF';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftInteger)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEORIGEM: Integer read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('MF_CIDADEORIGEM', ftString, 100)]
    [Dictionary('MF_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_CIDADEORIGEM: String read FMF_CIDADEORIGEM write FMF_CIDADEORIGEM;
    const MF_CIDADEORIGEM_Name = 'MF_CIDADEORIGEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_MANIFESTOCARGA_NOTAS)

end.
