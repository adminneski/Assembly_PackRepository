unit express.dbo.SPED_R_0400;

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
  [Table('SPED_R_0400', '')]
  TDtoSPED_R_0400 = class
  private
    { Private declarations } 
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FCOD_NAT: Integer;
    FDESCR_NAT: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_0400';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

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
  TRegisterClass.RegisterEntity(TDtoSPED_R_0400)

end.
