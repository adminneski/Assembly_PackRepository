unit express.dbo.FAT_CONSULTAENTREGAPRODUTO;

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
  [Table('FAT_ConsultaEntregaProduto', '')]
  TDtoFAT_ConsultaEntregaProduto = class
  private
    { Private declarations } 
    FFAT_TIPODOCTO: String;
    FFAT_ID: Integer;
    FFAT_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_QTDFATURADA: Currency;
    FPRO_CODIGO: Integer;
    FFAT_NUMERODOCTO: String;
    FPES_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FFAT_NOTAFISCAL: String;
    FFAT_DATAEMISSAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'FAT_ConsultaEntregaProduto';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPODOCTO', ftString, 3)]
    [Dictionary('FAT_TIPODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPODOCTO: String read FFAT_TIPODOCTO write FFAT_TIPODOCTO;
    const FAT_TIPODOCTO_Name = 'FAT_TIPODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID: Integer read FFAT_01_ID write FFAT_01_ID;
    const FAT_01_ID_Name = 'FAT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_QTDFATURADA', ftCurrency)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Currency read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAEMISSAO', ftDateTime)]
    [Dictionary('FAT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAEMISSAO: TDateTime read FFAT_DATAEMISSAO write FFAT_DATAEMISSAO;
    const FAT_DATAEMISSAO_Name = 'FAT_DATAEMISSAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_ConsultaEntregaProduto)

end.
