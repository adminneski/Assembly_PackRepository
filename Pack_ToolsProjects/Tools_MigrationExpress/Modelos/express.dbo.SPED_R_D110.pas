unit express.dbo.SPED_R_D110;

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
  [Table('SPED_R_D110', '')]
  TDtoSPED_R_D110 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FTIPO_DOC: String;
    FID_DOC: Integer;
    FNUM_ITEM: Integer;
    FCOD_ITEM: Integer;
    FVL_SERV: Double;
    FVL_OUT: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_D110';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('NUM_ITEM', ftInteger)]
    [Dictionary('NUM_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NUM_ITEM: Integer read FNUM_ITEM write FNUM_ITEM;
    const NUM_ITEM_Name = 'NUM_ITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate])]
    [Column('VL_SERV', ftBCD, 10, 2)]
    [Dictionary('VL_SERV', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_SERV: Double read FVL_SERV write FVL_SERV;
    const VL_SERV_Name = 'VL_SERV';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_OUT', ftInteger)]
    [Dictionary('VL_OUT', 'Mensagem de validação', '0', '', '', taCenter)]
    property VL_OUT: Integer read FVL_OUT write FVL_OUT;
    const VL_OUT_Name = 'VL_OUT';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_D110)

end.
