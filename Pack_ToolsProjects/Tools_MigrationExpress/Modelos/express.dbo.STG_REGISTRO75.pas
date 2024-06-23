unit express.dbo.STG_REGISTRO75;

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
  [Table('STG_REGISTRO75', '')]
  TDtoSTG_REGISTRO75 = class
  private
    { Private declarations } 
    FSTG_MES: Integer;
    FSTG_ANO: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCLF_CODIGO: String;
    FPRO_DESCRICAO: String;
    FSGM_CODIGO: String;
    FSTG_PORCENTOIPI: Integer;
    FSTG_PORCENTOICMS: Integer;
    FSTG_FATORBCR: Integer;
    FSTG_BASESUBSTITUICAO: Integer;
    FSTG_TIPO: String;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO75';

    [Restrictions([NoValidate])]
    [Column('STG_MES', ftInteger)]
    [Dictionary('STG_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_MES: Integer read FSTG_MES write FSTG_MES;
    const STG_MES_Name = 'STG_MES';

    [Restrictions([NoValidate])]
    [Column('STG_ANO', ftInteger)]
    [Dictionary('STG_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ANO: Integer read FSTG_ANO write FSTG_ANO;
    const STG_ANO_Name = 'STG_ANO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 300)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_PORCENTOIPI', ftInteger)]
    [Dictionary('STG_PORCENTOIPI', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_PORCENTOIPI: Integer read FSTG_PORCENTOIPI write FSTG_PORCENTOIPI;
    const STG_PORCENTOIPI_Name = 'STG_PORCENTOIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_PORCENTOICMS', ftInteger)]
    [Dictionary('STG_PORCENTOICMS', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_PORCENTOICMS: Integer read FSTG_PORCENTOICMS write FSTG_PORCENTOICMS;
    const STG_PORCENTOICMS_Name = 'STG_PORCENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_FATORBCR', ftInteger)]
    [Dictionary('STG_FATORBCR', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_FATORBCR: Integer read FSTG_FATORBCR write FSTG_FATORBCR;
    const STG_FATORBCR_Name = 'STG_FATORBCR';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_BASESUBSTITUICAO', ftInteger)]
    [Dictionary('STG_BASESUBSTITUICAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_BASESUBSTITUICAO: Integer read FSTG_BASESUBSTITUICAO write FSTG_BASESUBSTITUICAO;
    const STG_BASESUBSTITUICAO_Name = 'STG_BASESUBSTITUICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TIPO', ftString, 4)]
    [Dictionary('STG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPO: String read FSTG_TIPO write FSTG_TIPO;
    const STG_TIPO_Name = 'STG_TIPO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO75)

end.
