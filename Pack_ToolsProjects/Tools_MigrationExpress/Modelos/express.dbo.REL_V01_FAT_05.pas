unit express.dbo.REL_V01_FAT_05;

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
  [Table('REL_V01_FAT_05', '')]
  TDtoREL_V01_FAT_05 = class
  private
    { Private declarations } 
    FFAT_TIPO: String;
    FFAT_SIGLA: String;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_NOTAFISCAL: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FFAT_PERCENTUALRATEIO: Double;
    FFAT_DESATIVADO: String;
    FFAT_CANCELADA: String;
    FPES_NOME: String;
    FFAT_VALORRATEIO: Double;
    FNTO_MODELOOPERACAO: String;
    FFAT_PRECOLIQUIDO: Double;
    FPRO_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT_05';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate])]
    [Column('FAT_SIGLA', ftString, 3)]
    [Dictionary('FAT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SIGLA: String read FFAT_SIGLA write FFAT_SIGLA;
    const FAT_SIGLA_Name = 'FAT_SIGLA';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('FAT_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALRATEIO: Double read FFAT_PERCENTUALRATEIO write FFAT_PERCENTUALRATEIO;
    const FAT_PERCENTUALRATEIO_Name = 'FAT_PERCENTUALRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORRATEIO', ftBCD)]
    [Dictionary('FAT_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORRATEIO: Double read FFAT_VALORRATEIO write FFAT_VALORRATEIO;
    const FAT_VALORRATEIO_Name = 'FAT_VALORRATEIO';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_PRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOLIQUIDO: Double read FFAT_PRECOLIQUIDO write FFAT_PRECOLIQUIDO;
    const FAT_PRECOLIQUIDO_Name = 'FAT_PRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 300)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT_05)

end.
