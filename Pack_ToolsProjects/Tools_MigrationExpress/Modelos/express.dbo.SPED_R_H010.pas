unit express.dbo.SPED_R_H010;

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
  [Table('SPED_R_H010', '')]
  TDtoSPED_R_H010 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_INV: TDateTime;
    FCOD_ITEM: Integer;
    FUNID: String;
    FQTD: Double;
    FVL_UNIT: Double;
    FVL_ITEM: Double;
    FIND_PROP: String;
    FCOD_PART: String;
    FTXT_COMPL: String;
    FCOD_CTA: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_H010';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate])]
    [Column('UNID', ftString, 2)]
    [Dictionary('UNID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UNID: String read FUNID write FUNID;
    const UNID_Name = 'UNID';

    [Restrictions([NoValidate, NotNull])]
    [Column('QTD', ftBCD, 18, 4)]
    [Dictionary('QTD', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property QTD: Double read FQTD write FQTD;
    const QTD_Name = 'QTD';

    [Restrictions([NoValidate, NotNull])]
    [Column('VL_UNIT', ftBCD, 18, 4)]
    [Dictionary('VL_UNIT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_UNIT: Double read FVL_UNIT write FVL_UNIT;
    const VL_UNIT_Name = 'VL_UNIT';

    [Restrictions([NoValidate])]
    [Column('VL_ITEM', ftBCD)]
    [Dictionary('VL_ITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VL_ITEM: Double read FVL_ITEM write FVL_ITEM;
    const VL_ITEM_Name = 'VL_ITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_PROP', ftString, 1)]
    [Dictionary('IND_PROP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_PROP: String read FIND_PROP write FIND_PROP;
    const IND_PROP_Name = 'IND_PROP';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_PART', ftString, 1)]
    [Dictionary('COD_PART', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_PART: String read FCOD_PART write FCOD_PART;
    const COD_PART_Name = 'COD_PART';

    [Restrictions([NoValidate, NotNull])]
    [Column('TXT_COMPL', ftString, 1)]
    [Dictionary('TXT_COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TXT_COMPL: String read FTXT_COMPL write FTXT_COMPL;
    const TXT_COMPL_Name = 'TXT_COMPL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_CTA', ftString, 6)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_H010)

end.
