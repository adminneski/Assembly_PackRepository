unit express.dbo.REL_V01_FAT_09;

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
  [Table('REL_V01_FAT_09', '')]
  TDtoREL_V01_FAT_09 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FMNF_CODIGO: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_CANCELADA: String;
    FFAT_TOTALPARCELA: Double;
    FFAT_TOTALAVISTA: Double;
    FFAT_TOTALCHEQUE: Double;
    FFAT_TOTALCARTAO: Double;
    FFAT_TOTALDUPLICATA: Double;
    FFAT_TOTALBOLETO: Double;
    FFAT_TOTALPAGOANTECIPADO: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT_09';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPARCELA', ftBCD)]
    [Dictionary('FAT_TOTALPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPARCELA: Double read FFAT_TOTALPARCELA write FFAT_TOTALPARCELA;
    const FAT_TOTALPARCELA_Name = 'FAT_TOTALPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALAVISTA', ftBCD)]
    [Dictionary('FAT_TOTALAVISTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALAVISTA: Double read FFAT_TOTALAVISTA write FFAT_TOTALAVISTA;
    const FAT_TOTALAVISTA_Name = 'FAT_TOTALAVISTA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCHEQUE', ftBCD)]
    [Dictionary('FAT_TOTALCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCHEQUE: Double read FFAT_TOTALCHEQUE write FFAT_TOTALCHEQUE;
    const FAT_TOTALCHEQUE_Name = 'FAT_TOTALCHEQUE';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCARTAO', ftBCD)]
    [Dictionary('FAT_TOTALCARTAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCARTAO: Double read FFAT_TOTALCARTAO write FFAT_TOTALCARTAO;
    const FAT_TOTALCARTAO_Name = 'FAT_TOTALCARTAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDUPLICATA', ftBCD)]
    [Dictionary('FAT_TOTALDUPLICATA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDUPLICATA: Double read FFAT_TOTALDUPLICATA write FFAT_TOTALDUPLICATA;
    const FAT_TOTALDUPLICATA_Name = 'FAT_TOTALDUPLICATA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBOLETO', ftBCD)]
    [Dictionary('FAT_TOTALBOLETO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBOLETO: Double read FFAT_TOTALBOLETO write FFAT_TOTALBOLETO;
    const FAT_TOTALBOLETO_Name = 'FAT_TOTALBOLETO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPAGOANTECIPADO', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALPAGOANTECIPADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPAGOANTECIPADO: Double read FFAT_TOTALPAGOANTECIPADO write FFAT_TOTALPAGOANTECIPADO;
    const FAT_TOTALPAGOANTECIPADO_Name = 'FAT_TOTALPAGOANTECIPADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT_09)

end.
