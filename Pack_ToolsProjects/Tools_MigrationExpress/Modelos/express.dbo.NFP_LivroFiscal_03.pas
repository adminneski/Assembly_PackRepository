unit express.dbo.NFP_LIVROFISCAL_03;

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
  [Table('NFP_LivroFiscal_03', '')]
  TDtoNFP_LivroFiscal_03 = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FNFP_VALORITEM: Double;
    FNFP_VALORITEMBRUTO: Double;
    FNFP_VALORBCALCULOPISCOFINSITEM: Double;
    FNFP_VALORPISITEM: Double;
    FNFP_VALORCOFINSITEM: Double;
    FNFP_PERCENTUALPISITEM: Double;
    FNFP_PERCENTUALCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'NFP_LivroFiscal_03';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATALANCAMENTO: TDateTime read FNFP_DATALANCAMENTO write FNFP_DATALANCAMENTO;
    const NFP_DATALANCAMENTO_Name = 'NFP_DATALANCAMENTO';

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
    [Column('NFP_VALORITEM', ftBCD)]
    [Dictionary('NFP_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEM: Double read FNFP_VALORITEM write FNFP_VALORITEM;
    const NFP_VALORITEM_Name = 'NFP_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORITEMBRUTO', ftBCD)]
    [Dictionary('NFP_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORITEMBRUTO: Double read FNFP_VALORITEMBRUTO write FNFP_VALORITEMBRUTO;
    const NFP_VALORITEMBRUTO_Name = 'NFP_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFP_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORBCALCULOPISCOFINSITEM: Double read FNFP_VALORBCALCULOPISCOFINSITEM write FNFP_VALORBCALCULOPISCOFINSITEM;
    const NFP_VALORBCALCULOPISCOFINSITEM_Name = 'NFP_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORPISITEM', ftBCD)]
    [Dictionary('NFP_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORPISITEM: Double read FNFP_VALORPISITEM write FNFP_VALORPISITEM;
    const NFP_VALORPISITEM_Name = 'NFP_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_VALORCOFINSITEM', ftBCD)]
    [Dictionary('NFP_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORCOFINSITEM: Double read FNFP_VALORCOFINSITEM write FNFP_VALORCOFINSITEM;
    const NFP_VALORCOFINSITEM_Name = 'NFP_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFP_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALPISITEM: Double read FNFP_PERCENTUALPISITEM write FNFP_PERCENTUALPISITEM;
    const NFP_PERCENTUALPISITEM_Name = 'NFP_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('NFP_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALCOFINSITEM: Double read FNFP_PERCENTUALCOFINSITEM write FNFP_PERCENTUALCOFINSITEM;
    const NFP_PERCENTUALCOFINSITEM_Name = 'NFP_PERCENTUALCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_LivroFiscal_03)

end.
