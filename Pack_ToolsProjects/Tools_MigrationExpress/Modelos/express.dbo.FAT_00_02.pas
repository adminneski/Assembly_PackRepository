unit express.dbo.FAT_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.fat_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('FAT_00_02', '')]
  [PrimaryKey('FAT_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_02_ID')]
  TDtoFAT_00_02 = class
  private
    { Private declarations } 
    FFAT_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FMDO_CODIGO: Integer;
    FCSTPC_CODIGO: String;
    FFAT_GARANTIASERVICO: String;
    FFAT_QTDHORAS: Double;
    FFAT_ORDEMITEM: Integer;
    FFAT_VALORSERVICO: Double;
    FFAT_VALORPISITEM: Double;
    FFAT_VALORISSITEM: Double;
    FFAT_VALORCOFINSITEM: Double;
    FFAT_VALORBASECALCULOISSITEM: Double;
    FFAT_VALORBCALCULOPISCOFINSITEM: Double;
    FFAT_VALORLIQUIDOSERVICO: Double;
    FFAT_PERCENTUALISSITEM: Double;
    FFAT_PERCENTUALPISITEM: Double;
    FFAT_PERCENTUALCOFINSITEM: Double;
    FFAT_TOTALISSITEM: Double;
    FFAT_TOTALPISITEM: Double;
    FFAT_TOTALSERVICO: Double;
    FFAT_TOTALCOFINSITEM: Double;
    FFAT_TOTALBASECALCULOISSITEM: Double;
    FFAT_TOTALBCALCULOPISCOFINSITEM: Double;
    FFAT_TOTALLIQUIDOSERVICO: Double;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_02_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_CSTIPI: String;
    FMDO_DESCRICAO: String;
    FFAT_INTEGRACAOERP: String;
    FFAT_VALORINSSITEM: Double;
    FFAT_PERCENTUALINSSITEM: Double;
    FFAT_TOTALINSSITEM: Double;
    FFAT_VALORIRITEM: Double;
    FFAT_PERCENTUALIRITEM: Double;
    FFAT_TOTALIRITEM: Double;
    FFAT_VALORCSLLITEM: Double;
    FFAT_PERCENTUALCSLLITEM: Double;
    FFAT_TOTALCSLLITEM: Double;
    FFAT_PERCENTUALPISCOFINSITEM: Double;
  public
    { Public declarations }
    const Table      = 'FAT_00_02';
    const PrimaryKey = 'FAT_02_ID';
    const Sequence   = 'SEQ_FAT_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_02_ID', ftInteger)]
    [Dictionary('FAT_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_02_ID: Integer read FFAT_02_ID write FFAT_02_ID;
    const FAT_02_ID_Name = 'FAT_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_00_02_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_GARANTIASERVICO', ftString, 2)]
    [Dictionary('FAT_GARANTIASERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_GARANTIASERVICO: String read FFAT_GARANTIASERVICO write FFAT_GARANTIASERVICO;
    const FAT_GARANTIASERVICO_Name = 'FAT_GARANTIASERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_QTDHORAS', ftBCD)]
    [Dictionary('FAT_QTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDHORAS: Double read FFAT_QTDHORAS write FFAT_QTDHORAS;
    const FAT_QTDHORAS_Name = 'FAT_QTDHORAS';

    [Restrictions([NoValidate])]
    [Column('FAT_ORDEMITEM', ftInteger)]
    [Dictionary('FAT_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ORDEMITEM: Integer read FFAT_ORDEMITEM write FFAT_ORDEMITEM;
    const FAT_ORDEMITEM_Name = 'FAT_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORSERVICO', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORSERVICO: Double read FFAT_VALORSERVICO write FFAT_VALORSERVICO;
    const FAT_VALORSERVICO_Name = 'FAT_VALORSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPISITEM: Double read FFAT_VALORPISITEM write FFAT_VALORPISITEM;
    const FAT_VALORPISITEM_Name = 'FAT_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORISSITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORISSITEM: Double read FFAT_VALORISSITEM write FFAT_VALORISSITEM;
    const FAT_VALORISSITEM_Name = 'FAT_VALORISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCOFINSITEM: Double read FFAT_VALORCOFINSITEM write FFAT_VALORCOFINSITEM;
    const FAT_VALORCOFINSITEM_Name = 'FAT_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBASECALCULOISSITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBASECALCULOISSITEM: Double read FFAT_VALORBASECALCULOISSITEM write FFAT_VALORBASECALCULOISSITEM;
    const FAT_VALORBASECALCULOISSITEM_Name = 'FAT_VALORBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORBCALCULOPISCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORBCALCULOPISCOFINSITEM: Double read FFAT_VALORBCALCULOPISCOFINSITEM write FFAT_VALORBCALCULOPISCOFINSITEM;
    const FAT_VALORBCALCULOPISCOFINSITEM_Name = 'FAT_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORLIQUIDOSERVICO', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORLIQUIDOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORLIQUIDOSERVICO: Double read FFAT_VALORLIQUIDOSERVICO write FFAT_VALORLIQUIDOSERVICO;
    const FAT_VALORLIQUIDOSERVICO_Name = 'FAT_VALORLIQUIDOSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALISSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALISSITEM: Double read FFAT_PERCENTUALISSITEM write FFAT_PERCENTUALISSITEM;
    const FAT_PERCENTUALISSITEM_Name = 'FAT_PERCENTUALISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALPISITEM: Double read FFAT_PERCENTUALPISITEM write FFAT_PERCENTUALPISITEM;
    const FAT_PERCENTUALPISITEM_Name = 'FAT_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOFINSITEM: Double read FFAT_PERCENTUALCOFINSITEM write FFAT_PERCENTUALCOFINSITEM;
    const FAT_PERCENTUALCOFINSITEM_Name = 'FAT_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALISSITEM', ftBCD)]
    [Dictionary('FAT_TOTALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALISSITEM: Double read FFAT_TOTALISSITEM write FFAT_TOTALISSITEM;
    const FAT_TOTALISSITEM_Name = 'FAT_TOTALISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPISITEM', ftBCD)]
    [Dictionary('FAT_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPISITEM: Double read FFAT_TOTALPISITEM write FFAT_TOTALPISITEM;
    const FAT_TOTALPISITEM_Name = 'FAT_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSERVICO', ftBCD)]
    [Dictionary('FAT_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSERVICO: Double read FFAT_TOTALSERVICO write FFAT_TOTALSERVICO;
    const FAT_TOTALSERVICO_Name = 'FAT_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('FAT_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOFINSITEM: Double read FFAT_TOTALCOFINSITEM write FFAT_TOTALCOFINSITEM;
    const FAT_TOTALCOFINSITEM_Name = 'FAT_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOISSITEM', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOISSITEM: Double read FFAT_TOTALBASECALCULOISSITEM write FFAT_TOTALBASECALCULOISSITEM;
    const FAT_TOTALBASECALCULOISSITEM_Name = 'FAT_TOTALBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('FAT_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBCALCULOPISCOFINSITEM: Double read FFAT_TOTALBCALCULOPISCOFINSITEM write FFAT_TOTALBCALCULOPISCOFINSITEM;
    const FAT_TOTALBCALCULOPISCOFINSITEM_Name = 'FAT_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALLIQUIDOSERVICO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDOSERVICO: Double read FFAT_TOTALLIQUIDOSERVICO write FFAT_TOTALLIQUIDOSERVICO;
    const FAT_TOTALLIQUIDOSERVICO_Name = 'FAT_TOTALLIQUIDOSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_02_ID_OLD', ftInteger)]
    [Dictionary('FAT_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_02_ID_OLD: Integer read FFAT_02_ID_OLD write FFAT_02_ID_OLD;
    const FAT_02_ID_OLD_Name = 'FAT_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_CSTIPI', ftString, 2)]
    [Dictionary('FAT_CSTIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CSTIPI: String read FFAT_CSTIPI write FFAT_CSTIPI;
    const FAT_CSTIPI_Name = 'FAT_CSTIPI';

    [Restrictions([NoValidate])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORINSSITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORINSSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORINSSITEM: Double read FFAT_VALORINSSITEM write FFAT_VALORINSSITEM;
    const FAT_VALORINSSITEM_Name = 'FAT_VALORINSSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALINSSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALINSSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALINSSITEM: Double read FFAT_PERCENTUALINSSITEM write FFAT_PERCENTUALINSSITEM;
    const FAT_PERCENTUALINSSITEM_Name = 'FAT_PERCENTUALINSSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALINSSITEM', ftBCD)]
    [Dictionary('FAT_TOTALINSSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALINSSITEM: Double read FFAT_TOTALINSSITEM write FFAT_TOTALINSSITEM;
    const FAT_TOTALINSSITEM_Name = 'FAT_TOTALINSSITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORIRITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORIRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORIRITEM: Double read FFAT_VALORIRITEM write FFAT_VALORIRITEM;
    const FAT_VALORIRITEM_Name = 'FAT_VALORIRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIRITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALIRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIRITEM: Double read FFAT_PERCENTUALIRITEM write FFAT_PERCENTUALIRITEM;
    const FAT_PERCENTUALIRITEM_Name = 'FAT_PERCENTUALIRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIRITEM', ftBCD)]
    [Dictionary('FAT_TOTALIRITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIRITEM: Double read FFAT_TOTALIRITEM write FFAT_TOTALIRITEM;
    const FAT_TOTALIRITEM_Name = 'FAT_TOTALIRITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORCSLLITEM', ftBCD, 18, 4)]
    [Dictionary('FAT_VALORCSLLITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORCSLLITEM: Double read FFAT_VALORCSLLITEM write FFAT_VALORCSLLITEM;
    const FAT_VALORCSLLITEM_Name = 'FAT_VALORCSLLITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALCSLLITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALCSLLITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCSLLITEM: Double read FFAT_PERCENTUALCSLLITEM write FFAT_PERCENTUALCSLLITEM;
    const FAT_PERCENTUALCSLLITEM_Name = 'FAT_PERCENTUALCSLLITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCSLLITEM', ftBCD)]
    [Dictionary('FAT_TOTALCSLLITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCSLLITEM: Double read FFAT_TOTALCSLLITEM write FFAT_TOTALCSLLITEM;
    const FAT_TOTALCSLLITEM_Name = 'FAT_TOTALCSLLITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALPISCOFINSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALPISCOFINSITEM: Double read FFAT_PERCENTUALPISCOFINSITEM write FFAT_PERCENTUALPISCOFINSITEM;
    const FAT_PERCENTUALPISCOFINSITEM_Name = 'FAT_PERCENTUALPISCOFINSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_02)

end.
