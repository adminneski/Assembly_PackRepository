unit express.dbo.REL_V01_PVD;

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
  [Table('REL_V01_PVD', '')]
  TDtoREL_V01_PVD = class
  private
    { Private declarations } 
    FPVD_ID: Integer;
    FCOM_CODIGO: Integer;
    FPVD_OBSERVACAO: String;
    FPVD_DATALANCAMENTO: TDateTime;
    FPVD_NOTAATENDIMENTO: Double;
    FFAT_TIPO: String;
    FFAT_ID: Integer;
    FPES_CODIGO: Integer;
    FFAT_NOTAFISCAL: String;
    FFAT_NUMEROSERIEECF: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FPES_NOME: String;
    FFAT_TOTALLIQUIDO: Double;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FPVD_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_PVD';

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
    [Column('PVD_OBSERVACAO', ftString, 5000)]
    [Dictionary('PVD_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PVD_OBSERVACAO: String read FPVD_OBSERVACAO write FPVD_OBSERVACAO;
    const PVD_OBSERVACAO_Name = 'PVD_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PVD_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PVD_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PVD_DATALANCAMENTO: TDateTime read FPVD_DATALANCAMENTO write FPVD_DATALANCAMENTO;
    const PVD_DATALANCAMENTO_Name = 'PVD_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PVD_NOTAATENDIMENTO', ftBCD)]
    [Dictionary('PVD_NOTAATENDIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PVD_NOTAATENDIMENTO: Double read FPVD_NOTAATENDIMENTO write FPVD_NOTAATENDIMENTO;
    const PVD_NOTAATENDIMENTO_Name = 'PVD_NOTAATENDIMENTO';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROSERIEECF', ftString, 20)]
    [Dictionary('FAT_NUMEROSERIEECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROSERIEECF: String read FFAT_NUMEROSERIEECF write FFAT_NUMEROSERIEECF;
    const FAT_NUMEROSERIEECF_Name = 'FAT_NUMEROSERIEECF';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEVENDEDOR', ftString, 100)]
    [Dictionary('PES_NOMEVENDEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEVENDEDOR: String read FPES_NOMEVENDEDOR write FPES_NOMEVENDEDOR;
    const PES_NOMEVENDEDOR_Name = 'PES_NOMEVENDEDOR';

    [Restrictions([NoValidate])]
    [Column('PVD_DESATIVADO', ftString, 1)]
    [Dictionary('PVD_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PVD_DESATIVADO: String read FPVD_DESATIVADO write FPVD_DESATIVADO;
    const PVD_DESATIVADO_Name = 'PVD_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_PVD)

end.
