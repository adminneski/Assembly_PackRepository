unit express.dbo.STG_REGISTRO61;

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
  [Table('STG_REGISTRO61', '')]
  TDtoSTG_REGISTRO61 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FSTG_DATALANCAMENTO: TDateTime;
    FSTG_MODELO: String;
    FSTG_SERIE: String;
    FSTG_NOTAFISCAL: String;
    FSTG_TOTALNOTAFISCAL: Double;
    FSTG_TOTALBASECALCULOICMS: Double;
    FSTG_TOTALICMS: Double;
    FSTG_TOTALBASEISENTOICMS: Double;
    FSTG_TOTALBASEOUTROS: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO61';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('STG_DATALANCAMENTO', ftDateTime)]
    [Dictionary('STG_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATALANCAMENTO: TDateTime read FSTG_DATALANCAMENTO write FSTG_DATALANCAMENTO;
    const STG_DATALANCAMENTO_Name = 'STG_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('STG_MODELO', ftString, 2)]
    [Dictionary('STG_MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_MODELO: String read FSTG_MODELO write FSTG_MODELO;
    const STG_MODELO_Name = 'STG_MODELO';

    [Restrictions([NoValidate])]
    [Column('STG_SERIE', ftString, 3)]
    [Dictionary('STG_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_SERIE: String read FSTG_SERIE write FSTG_SERIE;
    const STG_SERIE_Name = 'STG_SERIE';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCAL', ftString, 9)]
    [Dictionary('STG_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCAL: String read FSTG_NOTAFISCAL write FSTG_NOTAFISCAL;
    const STG_NOTAFISCAL_Name = 'STG_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('STG_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALNOTAFISCAL: Double read FSTG_TOTALNOTAFISCAL write FSTG_TOTALNOTAFISCAL;
    const STG_TOTALNOTAFISCAL_Name = 'STG_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALBASECALCULOICMS', ftBCD, 48, 2)]
    [Dictionary('STG_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALBASECALCULOICMS: Double read FSTG_TOTALBASECALCULOICMS write FSTG_TOTALBASECALCULOICMS;
    const STG_TOTALBASECALCULOICMS_Name = 'STG_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALICMS', ftBCD)]
    [Dictionary('STG_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALICMS: Double read FSTG_TOTALICMS write FSTG_TOTALICMS;
    const STG_TOTALICMS_Name = 'STG_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('STG_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALBASEISENTOICMS: Double read FSTG_TOTALBASEISENTOICMS write FSTG_TOTALBASEISENTOICMS;
    const STG_TOTALBASEISENTOICMS_Name = 'STG_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALBASEOUTROS', ftBCD)]
    [Dictionary('STG_TOTALBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALBASEOUTROS: Double read FSTG_TOTALBASEOUTROS write FSTG_TOTALBASEOUTROS;
    const STG_TOTALBASEOUTROS_Name = 'STG_TOTALBASEOUTROS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO61)

end.
