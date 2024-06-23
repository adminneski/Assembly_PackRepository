unit express.dbo.STG_REGISTRO53;

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
  [Table('STG_REGISTRO53', '')]
  TDtoSTG_REGISTRO53 = class
  private
    { Private declarations } 
    FSTG_TIPO: String;
    FSTG_ID: Integer;
    FSTG_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FSTG_VALORBASECALCULOMVA: Double;
    FSTG_VALORICMSRNF: Double;
    FSTG_VALORDESPACESSORIA: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO53';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_VALORBASECALCULOMVA', ftBCD)]
    [Dictionary('STG_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASECALCULOMVA: Double read FSTG_VALORBASECALCULOMVA write FSTG_VALORBASECALCULOMVA;
    const STG_VALORBASECALCULOMVA_Name = 'STG_VALORBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_VALORICMSRNF', ftBCD)]
    [Dictionary('STG_VALORICMSRNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORICMSRNF: Double read FSTG_VALORICMSRNF write FSTG_VALORICMSRNF;
    const STG_VALORICMSRNF_Name = 'STG_VALORICMSRNF';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_VALORDESPACESSORIA', ftBCD)]
    [Dictionary('STG_VALORDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORDESPACESSORIA: Double read FSTG_VALORDESPACESSORIA write FSTG_VALORDESPACESSORIA;
    const STG_VALORDESPACESSORIA_Name = 'STG_VALORDESPACESSORIA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO53)

end.
