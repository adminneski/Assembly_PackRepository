unit express.dbo.STG_REGISTRO51;

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
  [Table('STG_REGISTRO51', '')]
  TDtoSTG_REGISTRO51 = class
  private
    { Private declarations } 
    FSTG_TIPO: String;
    FSTG_ID: Integer;
    FSTG_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FSTG_VALORIPI: Double;
    FSTG_VALORBASEISENTOICMS: Double;
    FSTG_VALORBASEOUTROS: Double;
    FSTG_VALORITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO51';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TIPO', ftString, 3)]
    [Dictionary('STG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPO: String read FSTG_TIPO write FSTG_TIPO;
    const STG_TIPO_Name = 'STG_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ID', ftInteger)]
    [Dictionary('STG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ID: Integer read FSTG_ID write FSTG_ID;
    const STG_ID_Name = 'STG_ID';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCAL', ftString, 9)]
    [Dictionary('STG_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCAL: String read FSTG_NOTAFISCAL write FSTG_NOTAFISCAL;
    const STG_NOTAFISCAL_Name = 'STG_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('STG_VALORIPI', ftBCD)]
    [Dictionary('STG_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORIPI: Double read FSTG_VALORIPI write FSTG_VALORIPI;
    const STG_VALORIPI_Name = 'STG_VALORIPI';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASEISENTOICMS', ftBCD)]
    [Dictionary('STG_VALORBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASEISENTOICMS: Double read FSTG_VALORBASEISENTOICMS write FSTG_VALORBASEISENTOICMS;
    const STG_VALORBASEISENTOICMS_Name = 'STG_VALORBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASEOUTROS', ftBCD)]
    [Dictionary('STG_VALORBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASEOUTROS: Double read FSTG_VALORBASEOUTROS write FSTG_VALORBASEOUTROS;
    const STG_VALORBASEOUTROS_Name = 'STG_VALORBASEOUTROS';

    [Restrictions([NoValidate])]
    [Column('STG_VALORITEM', ftBCD)]
    [Dictionary('STG_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORITEM: Double read FSTG_VALORITEM write FSTG_VALORITEM;
    const STG_VALORITEM_Name = 'STG_VALORITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO51)

end.
