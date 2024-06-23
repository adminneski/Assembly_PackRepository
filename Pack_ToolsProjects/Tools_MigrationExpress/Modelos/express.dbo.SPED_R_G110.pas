unit express.dbo.SPED_R_G110;

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
  [Table('SPED_R_G110', '')]
  TDtoSPED_R_G110 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FSALDO_IN_ICMS: Double;
    FSOM_PARC: Double;
    FVL_TRIB_EXP: Integer;
    FVL_TOTAL: Integer;
    FIND_PER_SAI: Integer;
    FICMS_APROP: Integer;
    FSOM_ICMS_OC: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_G110';

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

    [Restrictions([NoValidate])]
    [Column('SALDO_IN_ICMS', ftBCD)]
    [Dictionary('SALDO_IN_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SALDO_IN_ICMS: Double read FSALDO_IN_ICMS write FSALDO_IN_ICMS;
    const SALDO_IN_ICMS_Name = 'SALDO_IN_ICMS';

    [Restrictions([NoValidate])]
    [Column('SOM_PARC', ftBCD)]
    [Dictionary('SOM_PARC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SOM_PARC: Double read FSOM_PARC write FSOM_PARC;
    const SOM_PARC_Name = 'SOM_PARC';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TRIB_EXP', ftInteger)]
    [Dictionary('VL_TRIB_EXP', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TRIB_EXP: Integer read FVL_TRIB_EXP write FVL_TRIB_EXP;
    const VL_TRIB_EXP_Name = 'VL_TRIB_EXP';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_TOTAL', ftInteger)]
    [Dictionary('VL_TOTAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_TOTAL: Integer read FVL_TOTAL write FVL_TOTAL;
    const VL_TOTAL_Name = 'VL_TOTAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_PER_SAI', ftInteger)]
    [Dictionary('IND_PER_SAI', 'Mensagem de validação', '0', '', '', taCenter)]
    property IND_PER_SAI: Integer read FIND_PER_SAI write FIND_PER_SAI;
    const IND_PER_SAI_Name = 'IND_PER_SAI';

    [Restrictions([NoValidate, NotNull])]
    [Column('ICMS_APROP', ftInteger)]
    [Dictionary('ICMS_APROP', 'Mensagem de validação', '0', '', '', taCenter)]
    property ICMS_APROP: Integer read FICMS_APROP write FICMS_APROP;
    const ICMS_APROP_Name = 'ICMS_APROP';

    [Restrictions([NoValidate, NotNull])]
    [Column('SOM_ICMS_OC', ftInteger)]
    [Dictionary('SOM_ICMS_OC', 'Mensagem de validação', '0', '', '', taCenter)]
    property SOM_ICMS_OC: Integer read FSOM_ICMS_OC write FSOM_ICMS_OC;
    const SOM_ICMS_OC_Name = 'SOM_ICMS_OC';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_G110)

end.
