unit express.dbo.SPED_R_1400;

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
  [Table('SPED_R_1400', '')]
  TDtoSPED_R_1400 = class
  private
    { Private declarations } 
    FORDEM: String;
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FDT_DOC: TDateTime;
    FDT_E_S: TDateTime;
    FCOD_ITEM: String;
    FMUN: String;
    FVALOR: Double;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_1400';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORDEM', ftString, 1)]
    [Dictionary('ORDEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORDEM: String read FORDEM write FORDEM;
    const ORDEM_Name = 'ORDEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_E_S', ftDateTime)]
    [Dictionary('DT_E_S', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    const DT_E_S_Name = 'DT_E_S';

    [Restrictions([NoValidate])]
    [Column('COD_ITEM', ftString, 60)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_ITEM: String read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('MUN', ftString, 7)]
    [Dictionary('MUN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MUN: String read FMUN write FMUN;
    const MUN_Name = 'MUN';

    [Restrictions([NoValidate, NotNull])]
    [Column('VALOR', ftBCD)]
    [Dictionary('VALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VALOR: Double read FVALOR write FVALOR;
    const VALOR_Name = 'VALOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_1400)

end.
