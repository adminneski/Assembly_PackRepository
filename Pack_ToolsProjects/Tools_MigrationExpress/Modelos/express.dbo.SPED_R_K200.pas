unit express.dbo.SPED_R_K200;

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
  [Table('SPED_R_K200', '')]
  TDtoSPED_R_K200 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_EST: TDateTime;
    FCOD_ITEM: Integer;
    FQTD: Double;
    FIND_EST: String;
    FCOD_PART: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_K200';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DT_EST', ftDateTime)]
    [Dictionary('DT_EST', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DT_EST: TDateTime read FDT_EST write FDT_EST;
    const DT_EST_Name = 'DT_EST';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('QTD', ftBCD, 18, 4)]
    [Dictionary('QTD', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property QTD: Double read FQTD write FQTD;
    const QTD_Name = 'QTD';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_EST', ftString, 1)]
    [Dictionary('IND_EST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_EST: String read FIND_EST write FIND_EST;
    const IND_EST_Name = 'IND_EST';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_PART', ftString, 1)]
    [Dictionary('COD_PART', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_PART: String read FCOD_PART write FCOD_PART;
    const COD_PART_Name = 'COD_PART';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_K200)

end.
