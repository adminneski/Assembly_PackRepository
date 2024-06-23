unit express.dbo.SPEDPC_R_0500;

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
  [Table('SPEDPC_R_0500', '')]
  TDtoSPEDPC_R_0500 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FDT_DOC: TDateTime;
    FDT_ALT: TDateTime;
    FCOD_NAT_CC: String;
    FIND_CTA: String;
    FNIVEL: String;
    FCOD_CTA: String;
    FNOME_CTA: String;
    FTIPO_DOC: String;
    FNUM_DOC: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0500';

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
    [Column('COD_NAT_CC', ftString, 2)]
    [Dictionary('COD_NAT_CC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_NAT_CC: String read FCOD_NAT_CC write FCOD_NAT_CC;
    const COD_NAT_CC_Name = 'COD_NAT_CC';

    [Restrictions([NoValidate])]
    [Column('IND_CTA', ftString, 1)]
    [Dictionary('IND_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_CTA: String read FIND_CTA write FIND_CTA;
    const IND_CTA_Name = 'IND_CTA';

    [Restrictions([NoValidate])]
    [Column('NIVEL', ftString, 2)]
    [Dictionary('NIVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NIVEL: String read FNIVEL write FNIVEL;
    const NIVEL_Name = 'NIVEL';

    [Restrictions([NoValidate])]
    [Column('COD_CTA', ftString, 60)]
    [Dictionary('COD_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_CTA: String read FCOD_CTA write FCOD_CTA;
    const COD_CTA_Name = 'COD_CTA';

    [Restrictions([NoValidate])]
    [Column('NOME_CTA', ftString, 60)]
    [Dictionary('NOME_CTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NOME_CTA: String read FNOME_CTA write FNOME_CTA;
    const NOME_CTA_Name = 'NOME_CTA';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0500)

end.
