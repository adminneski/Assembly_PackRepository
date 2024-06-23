unit express.dbo.SPED_R_0300;

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
  [Table('SPED_R_0300', '')]
  TDtoSPED_R_0300 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FCOD_IND_BEM: Integer;
    FIDENT_MERC: String;
    FDESCR_ITEM: String;
    FCOD_PRNC: Integer;
    FCOD_CTA: String;
    FNR_PARC: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_0300';

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
    [Column('COD_IND_BEM', ftInteger)]
    [Dictionary('COD_IND_BEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_IND_BEM: Integer read FCOD_IND_BEM write FCOD_IND_BEM;
    const COD_IND_BEM_Name = 'COD_IND_BEM';

    [Restrictions([NoValidate])]
    [Column('IDENT_MERC', ftString, 1)]
    [Dictionary('IDENT_MERC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IDENT_MERC: String read FIDENT_MERC write FIDENT_MERC;
    const IDENT_MERC_Name = 'IDENT_MERC';

    [Restrictions([NoValidate, NotNull])]
    [Column('DESCR_ITEM', ftString, 100)]
    [Dictionary('DESCR_ITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCR_ITEM: String read FDESCR_ITEM write FDESCR_ITEM;
    const DESCR_ITEM_Name = 'DESCR_ITEM';

    [Restrictions([NoValidate])]
    [Column('COD_PRNC', ftInteger)]
    [Dictionary('COD_PRNC', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_PRNC: Integer read FCOD_PRNC write FCOD_PRNC;
    const COD_PRNC_Name = 'COD_PRNC';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate])]
    [Column('NR_PARC', ftInteger)]
    [Dictionary('NR_PARC', 'Mensagem de validação', '0', '', '', taCenter)]
    property NR_PARC: Integer read FNR_PARC write FNR_PARC;
    const NR_PARC_Name = 'NR_PARC';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_0300)

end.
