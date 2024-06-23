unit express.dbo.REL_V05_FAT;

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
  [Table('REL_V05_FAT', '')]
  TDtoREL_V05_FAT = class
  private
    { Private declarations } 
    FFAT_DATALANCAMENTO: TDateTime;
    FCOM_CODIGO: Integer;
    FFAT_VALORPARCELA: Double;
    FFAT_VALORAVISTA: Double;
    FFAT_VALORAPRAZO: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V05_FAT';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPARCELA', ftBCD)]
    [Dictionary('FAT_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPARCELA: Double read FFAT_VALORPARCELA write FFAT_VALORPARCELA;
    const FAT_VALORPARCELA_Name = 'FAT_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORAVISTA', ftBCD)]
    [Dictionary('FAT_VALORAVISTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORAVISTA: Double read FFAT_VALORAVISTA write FFAT_VALORAVISTA;
    const FAT_VALORAVISTA_Name = 'FAT_VALORAVISTA';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORAPRAZO', ftBCD)]
    [Dictionary('FAT_VALORAPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORAPRAZO: Double read FFAT_VALORAPRAZO write FFAT_VALORAPRAZO;
    const FAT_VALORAPRAZO_Name = 'FAT_VALORAPRAZO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V05_FAT)

end.
