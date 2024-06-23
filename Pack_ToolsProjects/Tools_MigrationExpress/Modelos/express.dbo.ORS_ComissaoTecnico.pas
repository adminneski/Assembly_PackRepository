unit express.dbo.ORS_COMISSAOTECNICO;

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
  [Table('ORS_ComissaoTecnico', '')]
  TDtoORS_ComissaoTecnico = class
  private
    { Private declarations } 
    FFAT_SIGLA: String;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FMDO_CODIGO: Integer;
    FMDO_DESCRICAO: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_NUMERODOCTO: String;
    FFAT_PERCENTUALRATEIO: Double;
    FPES_PERCENTUALCOMISSAOTECNICO: Double;
    FFAT_TOTALSERVICO: Double;
    FFAT_TOTALSERVICORATEADO: Double;
    FFAT_TOTALCOMISSAO: Double;
  public 
    { Public declarations } 
     const Table      = 'ORS_ComissaoTecnico';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_SIGLA', ftString, 3)]
    [Dictionary('FAT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SIGLA: String read FFAT_SIGLA write FFAT_SIGLA;
    const FAT_SIGLA_Name = 'FAT_SIGLA';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 10)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALRATEIO', ftBCD, 48, 2)]
    [Dictionary('FAT_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALRATEIO: Double read FFAT_PERCENTUALRATEIO write FFAT_PERCENTUALRATEIO;
    const FAT_PERCENTUALRATEIO_Name = 'FAT_PERCENTUALRATEIO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALCOMISSAOTECNICO', ftBCD)]
    [Dictionary('PES_PERCENTUALCOMISSAOTECNICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAOTECNICO: Double read FPES_PERCENTUALCOMISSAOTECNICO write FPES_PERCENTUALCOMISSAOTECNICO;
    const PES_PERCENTUALCOMISSAOTECNICO_Name = 'PES_PERCENTUALCOMISSAOTECNICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSERVICO', ftBCD)]
    [Dictionary('FAT_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSERVICO: Double read FFAT_TOTALSERVICO write FFAT_TOTALSERVICO;
    const FAT_TOTALSERVICO_Name = 'FAT_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSERVICORATEADO', ftBCD)]
    [Dictionary('FAT_TOTALSERVICORATEADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSERVICORATEADO: Double read FFAT_TOTALSERVICORATEADO write FFAT_TOTALSERVICORATEADO;
    const FAT_TOTALSERVICORATEADO_Name = 'FAT_TOTALSERVICORATEADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOMISSAO', ftBCD)]
    [Dictionary('FAT_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMISSAO: Double read FFAT_TOTALCOMISSAO write FFAT_TOTALCOMISSAO;
    const FAT_TOTALCOMISSAO_Name = 'FAT_TOTALCOMISSAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_ComissaoTecnico)

end.
