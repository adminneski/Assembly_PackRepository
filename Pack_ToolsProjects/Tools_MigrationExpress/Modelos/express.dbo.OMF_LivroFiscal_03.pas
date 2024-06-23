unit express.dbo.OMF_LIVROFISCAL_03;

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
  [Table('OMF_LivroFiscal_03', '')]
  TDtoOMF_LivroFiscal_03 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FOMF_VALORITEM: Double;
    FOMF_VALORITEMBRUTO: Double;
    FOMF_VALORBCALCULOPISCOFINSITEM: Double;
    FOMF_VALORPISITEM: Double;
    FOMF_VALORCOFINSITEM: Double;
    FOMF_PERCENTUALPISITEM: Double;
    FOMF_PERCENTUALCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'OMF_LivroFiscal_03';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('OMF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATALANCAMENTO: TDateTime read FOMF_DATALANCAMENTO write FOMF_DATALANCAMENTO;
    const OMF_DATALANCAMENTO_Name = 'OMF_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORITEM', ftBCD)]
    [Dictionary('OMF_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEM: Double read FOMF_VALORITEM write FOMF_VALORITEM;
    const OMF_VALORITEM_Name = 'OMF_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORITEMBRUTO', ftBCD)]
    [Dictionary('OMF_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORITEMBRUTO: Double read FOMF_VALORITEMBRUTO write FOMF_VALORITEMBRUTO;
    const OMF_VALORITEMBRUTO_Name = 'OMF_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('OMF_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORBCALCULOPISCOFINSITEM: Double read FOMF_VALORBCALCULOPISCOFINSITEM write FOMF_VALORBCALCULOPISCOFINSITEM;
    const OMF_VALORBCALCULOPISCOFINSITEM_Name = 'OMF_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORPISITEM', ftBCD)]
    [Dictionary('OMF_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORPISITEM: Double read FOMF_VALORPISITEM write FOMF_VALORPISITEM;
    const OMF_VALORPISITEM_Name = 'OMF_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('OMF_VALORCOFINSITEM', ftBCD, 48, 2)]
    [Dictionary('OMF_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORCOFINSITEM: Double read FOMF_VALORCOFINSITEM write FOMF_VALORCOFINSITEM;
    const OMF_VALORCOFINSITEM_Name = 'OMF_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALPISITEM: Double read FOMF_PERCENTUALPISITEM write FOMF_PERCENTUALPISITEM;
    const OMF_PERCENTUALPISITEM_Name = 'OMF_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('OMF_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALCOFINSITEM: Double read FOMF_PERCENTUALCOFINSITEM write FOMF_PERCENTUALCOFINSITEM;
    const OMF_PERCENTUALCOFINSITEM_Name = 'OMF_PERCENTUALCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_LivroFiscal_03)

end.
