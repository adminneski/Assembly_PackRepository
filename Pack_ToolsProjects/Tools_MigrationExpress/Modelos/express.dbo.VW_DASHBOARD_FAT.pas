unit express.dbo.VW_DASHBOARD_FAT;

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
  [Table('VW_DASHBOARD_FAT', '')]
  TDtoVW_DASHBOARD_FAT = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FTOTAL_PRODUTOS: Currency;
    FTOTAL_SERVI�OS: Double;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
  public 
    { Public declarations } 
     const Table      = 'VW_DASHBOARD_FAT';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de valida��o', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOTAL_PRODUTOS', ftCurrency)]
    [Dictionary('TOTAL_PRODUTOS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property TOTAL_PRODUTOS: Currency read FTOTAL_PRODUTOS write FTOTAL_PRODUTOS;
    const TOTAL_PRODUTOS_Name = 'TOTAL_PRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOTAL_SERVI�OS', ftBCD)]
    [Dictionary('TOTAL_SERVI�OS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property TOTAL_SERVI�OS: Double read FTOTAL_SERVI�OS write FTOTAL_SERVI�OS;
    const TOTAL_SERVI�OS_Name = 'TOTAL_SERVI�OS';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEVENDEDOR', ftString, 100)]
    [Dictionary('PES_NOMEVENDEDOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_NOMEVENDEDOR: String read FPES_NOMEVENDEDOR write FPES_NOMEVENDEDOR;
    const PES_NOMEVENDEDOR_Name = 'PES_NOMEVENDEDOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_DASHBOARD_FAT)

end.
