unit express.dbo.SPEDPC_R_0400;

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
  [Table('SPEDPC_R_0400', '')]
  TDtoSPEDPC_R_0400 = class
  private
    { Private declarations } 
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FCOD_NAT: Integer;
    FDESCR_NAT: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0400';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COD_NAT', ftInteger)]
    [Dictionary('COD_NAT', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_NAT: Integer read FCOD_NAT write FCOD_NAT;
    const COD_NAT_Name = 'COD_NAT';

    [Restrictions([NoValidate])]
    [Column('DESCR_NAT', ftString, 50)]
    [Dictionary('DESCR_NAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCR_NAT: String read FDESCR_NAT write FDESCR_NAT;
    const DESCR_NAT_Name = 'DESCR_NAT';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0400)

end.
