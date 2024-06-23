unit express.dbo.STG_PRODUTOS;

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
  [Table('STG_PRODUTOS', '')]
  TDtoSTG_PRODUTOS = class
  private
    { Private declarations } 
    FPRO_TIPO: String;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FSGM_CODIGO: String;
    FCLF_CODIGO: String;
    FAQT_ALIQUOTAECF: String;
  public 
    { Public declarations } 
     const Table      = 'STG_PRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_TIPO', ftString, 3)]
    [Dictionary('PRO_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPO: String read FPRO_TIPO write FPRO_TIPO;
    const PRO_TIPO_Name = 'PRO_TIPO';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESCRICAO', ftString, 300)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTAECF', ftString, 5)]
    [Dictionary('AQT_ALIQUOTAECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_ALIQUOTAECF: String read FAQT_ALIQUOTAECF write FAQT_ALIQUOTAECF;
    const AQT_ALIQUOTAECF_Name = 'AQT_ALIQUOTAECF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_PRODUTOS)

end.
