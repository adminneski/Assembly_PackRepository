unit express.dbo.RCC_00_01;

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
  [Table('RCC_00_01', '')]
  [PrimaryKey('RCC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RCC_01_ID')]
  TDtoRCC_00_01 = class
  private
    { Private declarations } 
    FRCC_01_ID: Integer;
    FRCC_ID: Integer;
    FRCC_MES: String;
    FRCC_PERCENTUAL: Double;
    FRCC_01_ID_OLD: Integer;
    FRCC_ID_OLD: Integer;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'RCC_00_01';
     const PrimaryKey = 'RCC_01_ID';
     const Sequence   = 'SEQ_RCC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_01_ID', ftInteger)]
    [Dictionary('RCC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_01_ID: Integer read FRCC_01_ID write FRCC_01_ID;
    const RCC_01_ID_Name = 'RCC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_ID', ftInteger)]
    [Dictionary('RCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_ID: Integer read FRCC_ID write FRCC_ID;
    const RCC_ID_Name = 'RCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_MES', ftString, 3)]
    [Dictionary('RCC_MES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RCC_MES: String read FRCC_MES write FRCC_MES;
    const RCC_MES_Name = 'RCC_MES';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_PERCENTUAL', ftBCD, 1599096398, 2)]
    [Dictionary('RCC_PERCENTUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RCC_PERCENTUAL: Double read FRCC_PERCENTUAL write FRCC_PERCENTUAL;
    const RCC_PERCENTUAL_Name = 'RCC_PERCENTUAL';

    [Restrictions([NoValidate])]
    [Column('RCC_01_ID_OLD', ftInteger)]
    [Dictionary('RCC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_01_ID_OLD: Integer read FRCC_01_ID_OLD write FRCC_01_ID_OLD;
    const RCC_01_ID_OLD_Name = 'RCC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('RCC_ID_OLD', ftInteger)]
    [Dictionary('RCC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_ID_OLD: Integer read FRCC_ID_OLD write FRCC_ID_OLD;
    const RCC_ID_OLD_Name = 'RCC_ID_OLD';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRCC_00_01)

end.
