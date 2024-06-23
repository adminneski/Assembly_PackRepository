unit express.dbo.FAT_SELECIONACOMISSAO;

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
  [Table('FAT_SelecionaComissao', '')]
  TDtoFAT_SelecionaComissao = class
  private
    { Private declarations } 
    FFAT_SIGLA: String;
    FNTO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_PERCENTUALCOMISSAO: Double;
    FFAT_TOTALLIQUIDO: Double;
    FFAT_TOTALBASECOMISSAO: Double;
    FFAT_PERCENTUALBASECOMISSAO: Double;
    FFAT_NOTAFISCAL: String;
    FFAT_NUMERODOCTO: String;
    FFAT_NUMERODOCTOREPRESENTANTE: String;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FFAT_VALORPARCELA: Double;
    FVND_CODIGO: Integer;
    FFAT_ID: Integer;
  public 
    { Public declarations } 
     const Table      = 'FAT_SelecionaComissao';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_SIGLA', ftString, 3)]
    [Dictionary('FAT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SIGLA: String read FFAT_SIGLA write FFAT_SIGLA;
    const FAT_SIGLA_Name = 'FAT_SIGLA';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOMISSAO: Double read FFAT_PERCENTUALCOMISSAO write FFAT_PERCENTUALCOMISSAO;
    const FAT_PERCENTUALCOMISSAO_Name = 'FAT_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECOMISSAO', ftBCD)]
    [Dictionary('FAT_TOTALBASECOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECOMISSAO: Double read FFAT_TOTALBASECOMISSAO write FFAT_TOTALBASECOMISSAO;
    const FAT_TOTALBASECOMISSAO_Name = 'FAT_TOTALBASECOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALBASECOMISSAO', ftBCD)]
    [Dictionary('FAT_PERCENTUALBASECOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALBASECOMISSAO: Double read FFAT_PERCENTUALBASECOMISSAO write FFAT_PERCENTUALBASECOMISSAO;
    const FAT_PERCENTUALBASECOMISSAO_Name = 'FAT_PERCENTUALBASECOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTOREPRESENTANTE: String read FFAT_NUMERODOCTOREPRESENTANTE write FFAT_NUMERODOCTOREPRESENTANTE;
    const FAT_NUMERODOCTOREPRESENTANTE_Name = 'FAT_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPARCELA', ftBCD)]
    [Dictionary('FAT_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPARCELA: Double read FFAT_VALORPARCELA write FFAT_VALORPARCELA;
    const FAT_VALORPARCELA_Name = 'FAT_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_SelecionaComissao)

end.
