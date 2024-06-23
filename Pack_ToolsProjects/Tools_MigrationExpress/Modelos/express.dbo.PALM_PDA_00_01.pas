unit express.dbo.PALM_PDA_00_01;

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
  [Table('PALM_PDA_00_01', '')]
  TDtoPALM_PDA_00_01 = class
  private
    { Private declarations } 
    FPALM_ID: Integer;
    FPALM_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPALM_QTDPEDIDA: Double;
    FPALM_QTDATENDIDA: Double;
    FPALM_PRECOVENDA: Double;
    FPALM_PRECOTABELA: Double;
    FPALM_PRECOORIGINAL: Double;
  public 
    { Public declarations } 
     const Table      = 'PALM_PDA_00_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('PALM_ID', ftInteger)]
    [Dictionary('PALM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PALM_ID: Integer read FPALM_ID write FPALM_ID;
    const PALM_ID_Name = 'PALM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PALM_01_ID', ftInteger)]
    [Dictionary('PALM_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PALM_01_ID: Integer read FPALM_01_ID write FPALM_01_ID;
    const PALM_01_ID_Name = 'PALM_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PALM_QTDPEDIDA', ftBCD, 2097184, 3)]
    [Dictionary('PALM_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_QTDPEDIDA: Double read FPALM_QTDPEDIDA write FPALM_QTDPEDIDA;
    const PALM_QTDPEDIDA_Name = 'PALM_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('PALM_QTDATENDIDA', ftBCD, 5177428, 3)]
    [Dictionary('PALM_QTDATENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_QTDATENDIDA: Double read FPALM_QTDATENDIDA write FPALM_QTDATENDIDA;
    const PALM_QTDATENDIDA_Name = 'PALM_QTDATENDIDA';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOVENDA: Double read FPALM_PRECOVENDA write FPALM_PRECOVENDA;
    const PALM_PRECOVENDA_Name = 'PALM_PRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOTABELA: Double read FPALM_PRECOTABELA write FPALM_PRECOTABELA;
    const PALM_PRECOTABELA_Name = 'PALM_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOORIGINAL', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOORIGINAL: Double read FPALM_PRECOORIGINAL write FPALM_PRECOORIGINAL;
    const PALM_PRECOORIGINAL_Name = 'PALM_PRECOORIGINAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_PDA_00_01)

end.
