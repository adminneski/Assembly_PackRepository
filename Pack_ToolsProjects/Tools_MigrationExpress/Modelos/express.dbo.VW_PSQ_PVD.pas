unit express.dbo.VW_PSQ_PVD;

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
  [Table('VW_PSQ_PVD', '')]
  TDtoVW_PSQ_PVD = class
  private
    { Private declarations } 
    FPVD_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_TIPO: String;
    FFAT_ID: Integer;
    FFAT_NUMERODOCTO: String;
    FFAT_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPVD_DATALANCAMENTO: TDateTime;
    FPVD_OBSERVACAO: String;
    FPVD_NOTAATENDIMENTO: Double;
    FPVD_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PVD';

    [Restrictions([NoValidate, NotNull])]
    [Column('PVD_ID', ftInteger)]
    [Dictionary('PVD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PVD_ID: Integer read FPVD_ID write FPVD_ID;
    const PVD_ID_Name = 'PVD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PVD_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PVD_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PVD_DATALANCAMENTO: TDateTime read FPVD_DATALANCAMENTO write FPVD_DATALANCAMENTO;
    const PVD_DATALANCAMENTO_Name = 'PVD_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PVD_OBSERVACAO', ftString, 5000)]
    [Dictionary('PVD_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PVD_OBSERVACAO: String read FPVD_OBSERVACAO write FPVD_OBSERVACAO;
    const PVD_OBSERVACAO_Name = 'PVD_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PVD_NOTAATENDIMENTO', ftBCD)]
    [Dictionary('PVD_NOTAATENDIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PVD_NOTAATENDIMENTO: Double read FPVD_NOTAATENDIMENTO write FPVD_NOTAATENDIMENTO;
    const PVD_NOTAATENDIMENTO_Name = 'PVD_NOTAATENDIMENTO';

    [Restrictions([NoValidate])]
    [Column('PVD_DESATIVADO', ftString, 1)]
    [Dictionary('PVD_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PVD_DESATIVADO: String read FPVD_DESATIVADO write FPVD_DESATIVADO;
    const PVD_DESATIVADO_Name = 'PVD_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PVD)

end.
