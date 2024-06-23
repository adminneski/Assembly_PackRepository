unit express.dbo.NFE_LIVROFISCAL_03;

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
  [Table('NFE_LivroFiscal_03', '')]
  TDtoNFE_LivroFiscal_03 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_DATALANCAMENTO: TDateTime;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FNFE_VALORITEM: Double;
    FNFE_VALORITEMBRUTO: Double;
    FNFE_VALORBCALCULOPISCOFINSITEM: Double;
    FNFE_VALORPISITEM: Double;
    FNFE_VALORCOFINSITEM: Double;
    FNFE_PERCENTUALPISITEM: Double;
    FNFE_PERCENTUALCOFINSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'NFE_LivroFiscal_03';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFE_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATALANCAMENTO: TDateTime read FNFE_DATALANCAMENTO write FNFE_DATALANCAMENTO;
    const NFE_DATALANCAMENTO_Name = 'NFE_DATALANCAMENTO';

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
    [Column('NFE_VALORITEM', ftBCD, 48, 2)]
    [Dictionary('NFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEM: Double read FNFE_VALORITEM write FNFE_VALORITEM;
    const NFE_VALORITEM_Name = 'NFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORITEMBRUTO', ftBCD)]
    [Dictionary('NFE_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEMBRUTO: Double read FNFE_VALORITEMBRUTO write FNFE_VALORITEMBRUTO;
    const NFE_VALORITEMBRUTO_Name = 'NFE_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('NFE_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORBCALCULOPISCOFINSITEM: Double read FNFE_VALORBCALCULOPISCOFINSITEM write FNFE_VALORBCALCULOPISCOFINSITEM;
    const NFE_VALORBCALCULOPISCOFINSITEM_Name = 'NFE_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORPISITEM', ftBCD)]
    [Dictionary('NFE_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORPISITEM: Double read FNFE_VALORPISITEM write FNFE_VALORPISITEM;
    const NFE_VALORPISITEM_Name = 'NFE_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCOFINSITEM', ftBCD)]
    [Dictionary('NFE_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCOFINSITEM: Double read FNFE_VALORCOFINSITEM write FNFE_VALORCOFINSITEM;
    const NFE_VALORCOFINSITEM_Name = 'NFE_VALORCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALPISITEM: Double read FNFE_PERCENTUALPISITEM write FNFE_PERCENTUALPISITEM;
    const NFE_PERCENTUALPISITEM_Name = 'NFE_PERCENTUALPISITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALCOFINSITEM: Double read FNFE_PERCENTUALCOFINSITEM write FNFE_PERCENTUALCOFINSITEM;
    const NFE_PERCENTUALCOFINSITEM_Name = 'NFE_PERCENTUALCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_LivroFiscal_03)

end.
