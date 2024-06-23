unit express.dbo.STG_REGISTRO50;

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
  [Table('STG_REGISTRO50', '')]
  TDtoSTG_REGISTRO50 = class
  private
    { Private declarations } 
    FSTG_ID: Integer;
    FSTG_NOTAFISCAL: String;
    FSTG_TIPO: String;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FSTG_PERCENTUALICMS: Double;
    FSTG_VALORITEM: Double;
    FSTG_VALORBASEOUTROS: Double;
    FSTG_VALORICMS: Double;
    FSTG_VALORBASECALCULOICMS: Double;
    FSTG_VALORBASEISENTOICMS: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO50';

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
    [Column('STG_TIPO', ftString, 3)]
    [Dictionary('STG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPO: String read FSTG_TIPO write FSTG_TIPO;
    const STG_TIPO_Name = 'STG_TIPO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_PERCENTUALICMS', ftBCD, 10, 2)]
    [Dictionary('STG_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_PERCENTUALICMS: Double read FSTG_PERCENTUALICMS write FSTG_PERCENTUALICMS;
    const STG_PERCENTUALICMS_Name = 'STG_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('STG_VALORITEM', ftBCD)]
    [Dictionary('STG_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORITEM: Double read FSTG_VALORITEM write FSTG_VALORITEM;
    const STG_VALORITEM_Name = 'STG_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASEOUTROS', ftBCD)]
    [Dictionary('STG_VALORBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASEOUTROS: Double read FSTG_VALORBASEOUTROS write FSTG_VALORBASEOUTROS;
    const STG_VALORBASEOUTROS_Name = 'STG_VALORBASEOUTROS';

    [Restrictions([NoValidate])]
    [Column('STG_VALORICMS', ftBCD)]
    [Dictionary('STG_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORICMS: Double read FSTG_VALORICMS write FSTG_VALORICMS;
    const STG_VALORICMS_Name = 'STG_VALORICMS';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASECALCULOICMS', ftBCD, 48, 2)]
    [Dictionary('STG_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASECALCULOICMS: Double read FSTG_VALORBASECALCULOICMS write FSTG_VALORBASECALCULOICMS;
    const STG_VALORBASECALCULOICMS_Name = 'STG_VALORBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASEISENTOICMS', ftBCD)]
    [Dictionary('STG_VALORBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASEISENTOICMS: Double read FSTG_VALORBASEISENTOICMS write FSTG_VALORBASEISENTOICMS;
    const STG_VALORBASEISENTOICMS_Name = 'STG_VALORBASEISENTOICMS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO50)

end.
