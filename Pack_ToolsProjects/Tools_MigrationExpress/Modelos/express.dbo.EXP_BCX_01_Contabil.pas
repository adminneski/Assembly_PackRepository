unit express.dbo.EXP_BCX_01_CONTABIL;

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
  [Table('EXP_BCX_01_Contabil', '')]
  TDtoEXP_BCX_01_Contabil = class
  private
    { Private declarations } 
    FBCX_ID: Integer;
    FCOM_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FBCX_DC: String;
    FBCX_VALORRATEIO: Double;
    FPLC_SIGLACONTABIL: String;
    FPLC_INTEGRACAOCONTABIL: String;
    FHSP_CODIGO: Integer;
    FHSP_DESCRICAO: String;
    FPLC_HISTORICOPADRAOCONTABIL: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_BCX_01_Contabil';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ID', ftInteger)]
    [Dictionary('BCX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID: Integer read FBCX_ID write FBCX_ID;
    const BCX_ID_Name = 'BCX_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCX_DC', ftString, 1)]
    [Dictionary('BCX_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DC: String read FBCX_DC write FBCX_DC;
    const BCX_DC_Name = 'BCX_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORRATEIO', ftBCD, 10, 2)]
    [Dictionary('BCX_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORRATEIO: Double read FBCX_VALORRATEIO write FBCX_VALORRATEIO;
    const BCX_VALORRATEIO_Name = 'BCX_VALORRATEIO';

    [Restrictions([NoValidate])]
    [Column('PLC_SIGLACONTABIL', ftString, 3)]
    [Dictionary('PLC_SIGLACONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_SIGLACONTABIL: String read FPLC_SIGLACONTABIL write FPLC_SIGLACONTABIL;
    const PLC_SIGLACONTABIL_Name = 'PLC_SIGLACONTABIL';

    [Restrictions([NoValidate])]
    [Column('PLC_INTEGRACAOCONTABIL', ftString, 15)]
    [Dictionary('PLC_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_INTEGRACAOCONTABIL: String read FPLC_INTEGRACAOCONTABIL write FPLC_INTEGRACAOCONTABIL;
    const PLC_INTEGRACAOCONTABIL_Name = 'PLC_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HSP_DESCRICAO', ftString, 50)]
    [Dictionary('HSP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HSP_DESCRICAO: String read FHSP_DESCRICAO write FHSP_DESCRICAO;
    const HSP_DESCRICAO_Name = 'HSP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PLC_HISTORICOPADRAOCONTABIL', ftString, 1)]
    [Dictionary('PLC_HISTORICOPADRAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_HISTORICOPADRAOCONTABIL: String read FPLC_HISTORICOPADRAOCONTABIL write FPLC_HISTORICOPADRAOCONTABIL;
    const PLC_HISTORICOPADRAOCONTABIL_Name = 'PLC_HISTORICOPADRAOCONTABIL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_BCX_01_Contabil)

end.
