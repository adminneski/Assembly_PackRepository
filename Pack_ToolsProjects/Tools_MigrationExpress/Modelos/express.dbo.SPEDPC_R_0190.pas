unit express.dbo.SPEDPC_R_0190;

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
  [Table('SPEDPC_R_0190', '')]
  TDtoSPEDPC_R_0190 = class
  private
    { Private declarations } 
    FTIPO: String;
    FPRODUTO: Integer;
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FUNID: String;
    FDESCR: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0190';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRODUTO', ftInteger)]
    [Dictionary('PRODUTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRODUTO: Integer read FPRODUTO write FPRODUTO;
    const PRODUTO_Name = 'PRODUTO';

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
    [Column('UNID', ftString, 2)]
    [Dictionary('UNID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UNID: String read FUNID write FUNID;
    const UNID_Name = 'UNID';

    [Restrictions([NoValidate])]
    [Column('DESCR', ftString, 30)]
    [Dictionary('DESCR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCR: String read FDESCR write FDESCR;
    const DESCR_Name = 'DESCR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0190)

end.
