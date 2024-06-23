unit express.dbo.SPED_R_E110;

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
  [Table('SPED_R_E110', '')]
  TDtoSPED_R_E110 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FVL_TOT_DEBITOS: Double;
    FVL_AJ_DEBITOS: Integer;
    FVL_TOT_AJ_DEBITOS: Integer;
    FVL_ESTORNOS_CRED: Integer;
    FVL_TOT_CREDITOS: Double;
    FVL_AJ_CREDITOS: Integer;
    FVL_TOT_AJ_CREDITOS: Integer;
    FVL_ESTORNOS_DEB: Integer;
    FVL_SLD_CREDOR_ANT: Integer;
    FVL_SLD_APURADO: Integer;
    FVL_TOT_DED: Integer;
    FVL_ICMS_RECOLHER: Integer;
    FVL_SLD_CREDOR_TRANSPORTAR: Integer;
    FDEB_ESP: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_E110';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_DEBITOS', ftBCD, 10, 2)]
    [Dictionary('VL_TOT_DEBITOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_TOT_DEBITOS: Double read FVL_TOT_DEBITOS write FVL_TOT_DEBITOS;
    const VL_TOT_DEBITOS_Name = 'VL_TOT_DEBITOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_AJ_DEBITOS', ftInteger)]
    [Dictionary('VL_AJ_DEBITOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_AJ_DEBITOS: Integer read FVL_AJ_DEBITOS write FVL_AJ_DEBITOS;
    const VL_AJ_DEBITOS_Name = 'VL_AJ_DEBITOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_AJ_DEBITOS', ftInteger)]
    [Dictionary('VL_TOT_AJ_DEBITOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TOT_AJ_DEBITOS: Integer read FVL_TOT_AJ_DEBITOS write FVL_TOT_AJ_DEBITOS;
    const VL_TOT_AJ_DEBITOS_Name = 'VL_TOT_AJ_DEBITOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ESTORNOS_CRED', ftInteger)]
    [Dictionary('VL_ESTORNOS_CRED', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ESTORNOS_CRED: Integer read FVL_ESTORNOS_CRED write FVL_ESTORNOS_CRED;
    const VL_ESTORNOS_CRED_Name = 'VL_ESTORNOS_CRED';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_CREDITOS', ftBCD)]
    [Dictionary('VL_TOT_CREDITOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_TOT_CREDITOS: Double read FVL_TOT_CREDITOS write FVL_TOT_CREDITOS;
    const VL_TOT_CREDITOS_Name = 'VL_TOT_CREDITOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_AJ_CREDITOS', ftInteger)]
    [Dictionary('VL_AJ_CREDITOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_AJ_CREDITOS: Integer read FVL_AJ_CREDITOS write FVL_AJ_CREDITOS;
    const VL_AJ_CREDITOS_Name = 'VL_AJ_CREDITOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_AJ_CREDITOS', ftInteger)]
    [Dictionary('VL_TOT_AJ_CREDITOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TOT_AJ_CREDITOS: Integer read FVL_TOT_AJ_CREDITOS write FVL_TOT_AJ_CREDITOS;
    const VL_TOT_AJ_CREDITOS_Name = 'VL_TOT_AJ_CREDITOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ESTORNOS_DEB', ftInteger)]
    [Dictionary('VL_ESTORNOS_DEB', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ESTORNOS_DEB: Integer read FVL_ESTORNOS_DEB write FVL_ESTORNOS_DEB;
    const VL_ESTORNOS_DEB_Name = 'VL_ESTORNOS_DEB';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_SLD_CREDOR_ANT', ftInteger)]
    [Dictionary('VL_SLD_CREDOR_ANT', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_SLD_CREDOR_ANT: Integer read FVL_SLD_CREDOR_ANT write FVL_SLD_CREDOR_ANT;
    const VL_SLD_CREDOR_ANT_Name = 'VL_SLD_CREDOR_ANT';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_SLD_APURADO', ftInteger)]
    [Dictionary('VL_SLD_APURADO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_SLD_APURADO: Integer read FVL_SLD_APURADO write FVL_SLD_APURADO;
    const VL_SLD_APURADO_Name = 'VL_SLD_APURADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOT_DED', ftInteger)]
    [Dictionary('VL_TOT_DED', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TOT_DED: Integer read FVL_TOT_DED write FVL_TOT_DED;
    const VL_TOT_DED_Name = 'VL_TOT_DED';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_ICMS_RECOLHER', ftInteger)]
    [Dictionary('VL_ICMS_RECOLHER', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_ICMS_RECOLHER: Integer read FVL_ICMS_RECOLHER write FVL_ICMS_RECOLHER;
    const VL_ICMS_RECOLHER_Name = 'VL_ICMS_RECOLHER';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_SLD_CREDOR_TRANSPORTAR', ftInteger)]
    [Dictionary('VL_SLD_CREDOR_TRANSPORTAR', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_SLD_CREDOR_TRANSPORTAR: Integer read FVL_SLD_CREDOR_TRANSPORTAR write FVL_SLD_CREDOR_TRANSPORTAR;
    const VL_SLD_CREDOR_TRANSPORTAR_Name = 'VL_SLD_CREDOR_TRANSPORTAR';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEB_ESP', ftInteger)]
    [Dictionary('DEB_ESP', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEB_ESP: Integer read FDEB_ESP write FDEB_ESP;
    const DEB_ESP_Name = 'DEB_ESP';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_E110)

end.
