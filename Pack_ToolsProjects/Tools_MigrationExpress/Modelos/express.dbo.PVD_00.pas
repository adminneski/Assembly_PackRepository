unit express.dbo.PVD_00;

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
  [Table('PVD_00', '')]
  [PrimaryKey('PVD_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PVD_ID')]
  TDtoPVD_00 = class
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
    FPVD_DESATIVADO: String;
    FPVD_DATAALTERACAO: TDateTime;
    FPVD_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PVD_00';
     const PrimaryKey = 'PVD_ID';
     const Sequence   = 'SEQ_PVD_ID';

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
    [Column('PVD_NOTAATENDIMENTO', ftBCD, 659507017, 2)]
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
    [Column('PVD_DESATIVADO', ftString, 1)]
    [Dictionary('PVD_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PVD_DESATIVADO: String read FPVD_DESATIVADO write FPVD_DESATIVADO;
    const PVD_DESATIVADO_Name = 'PVD_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PVD_DATAALTERACAO', ftDateTime)]
    [Dictionary('PVD_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PVD_DATAALTERACAO: TDateTime read FPVD_DATAALTERACAO write FPVD_DATAALTERACAO;
    const PVD_DATAALTERACAO_Name = 'PVD_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PVD_ID_OLD', ftInteger)]
    [Dictionary('PVD_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PVD_ID_OLD: Integer read FPVD_ID_OLD write FPVD_ID_OLD;
    const PVD_ID_OLD_Name = 'PVD_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPVD_00)

end.
