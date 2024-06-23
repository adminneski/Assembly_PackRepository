unit express.dbo.SPED_R_H005;

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
  [Table('SPED_R_H005', '')]
  TDtoSPED_R_H005 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_INV: TDateTime;
    FVL_INV: Double;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_H005';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_INV', ftDateTime)]
    [Dictionary('DT_INV', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_INV: TDateTime read FDT_INV write FDT_INV;
    const DT_INV_Name = 'DT_INV';

    [Restrictions([NoValidate])]
    [Column('VL_INV', ftBCD)]
    [Dictionary('VL_INV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_INV: Double read FVL_INV write FVL_INV;
    const VL_INV_Name = 'VL_INV';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_H005)

end.
