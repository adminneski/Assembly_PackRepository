unit express.dbo.SPED_R_0305;

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
  [Table('SPED_R_0305', '')]
  TDtoSPED_R_0305 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FCOD_IND_BEM: Integer;
    FCOD_CCUS: String;
    FFUNC: String;
    FVIDA_UTIL: Integer;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_0305';

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
    [Column('COD_CCUS', ftString, 60)]
    [Dictionary('COD_CCUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CCUS: String read FCOD_CCUS write FCOD_CCUS;
    const COD_CCUS_Name = 'COD_CCUS';

    [Restrictions([NoValidate])]
    [Column('FUNC', ftString, 60)]
    [Dictionary('FUNC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FUNC: String read FFUNC write FFUNC;
    const FUNC_Name = 'FUNC';

    [Restrictions([NoValidate])]
    [Column('VIDA_UTIL', ftInteger)]
    [Dictionary('VIDA_UTIL', 'Mensagem de validação', '0', '', '', taCenter)]
    property VIDA_UTIL: Integer read FVIDA_UTIL write FVIDA_UTIL;
    const VIDA_UTIL_Name = 'VIDA_UTIL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_0305)

end.
