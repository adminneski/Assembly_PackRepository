unit express.dbo.LEE_TRIBUTACAOLEIESTADUAL;

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
  [Table('LEE_TributacaoLeiEstadual', '')]
  TDtoLEE_TributacaoLeiEstadual = class
  private
    { Private declarations } 
    FLEE_CODIGO: Integer;
    FLEE_UF: String;
    FNCM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FAQT_CODIGO: Integer;
    FAQT_ALIQUOTA: Double;
    FAQT_ALIQUOTAECF: String;
  public 
    { Public declarations } 
     const Table      = 'LEE_TributacaoLeiEstadual';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_UF', ftString, 2)]
    [Dictionary('LEE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_UF: String read FLEE_UF write FLEE_UF;
    const LEE_UF_Name = 'LEE_UF';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO', ftInteger)]
    [Dictionary('AQT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO: Integer read FAQT_CODIGO write FAQT_CODIGO;
    const AQT_CODIGO_Name = 'AQT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTA', ftBCD, 48, 2)]
    [Dictionary('AQT_ALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AQT_ALIQUOTA: Double read FAQT_ALIQUOTA write FAQT_ALIQUOTA;
    const AQT_ALIQUOTA_Name = 'AQT_ALIQUOTA';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTAECF', ftString, 5)]
    [Dictionary('AQT_ALIQUOTAECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_ALIQUOTAECF: String read FAQT_ALIQUOTAECF write FAQT_ALIQUOTAECF;
    const AQT_ALIQUOTAECF_Name = 'AQT_ALIQUOTAECF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLEE_TributacaoLeiEstadual)

end.
