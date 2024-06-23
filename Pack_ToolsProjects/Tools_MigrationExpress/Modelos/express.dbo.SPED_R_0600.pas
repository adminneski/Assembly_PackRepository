unit express.dbo.SPED_R_0600;

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
  [Table('SPED_R_0600', '')]
  TDtoSPED_R_0600 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FDT_ALT: TDateTime;
    FCOD_CCUS: String;
    FCCUS: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_0600';

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
    [Column('DT_ALT', ftDateTime)]
    [Dictionary('DT_ALT', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_ALT: TDateTime read FDT_ALT write FDT_ALT;
    const DT_ALT_Name = 'DT_ALT';

    [Restrictions([NoValidate])]
    [Column('COD_CCUS', ftString, 60)]
    [Dictionary('COD_CCUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CCUS: String read FCOD_CCUS write FCOD_CCUS;
    const COD_CCUS_Name = 'COD_CCUS';

    [Restrictions([NoValidate])]
    [Column('CCUS', ftString, 60)]
    [Dictionary('CCUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCUS: String read FCCUS write FCCUS;
    const CCUS_Name = 'CCUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_0600)

end.
