unit express.dbo.ORS_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ors_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ORS_00_02', '')]
  [PrimaryKey('ORS_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_02_ID')]
  TDtoORS_00_02 = class
  private
    { Private declarations } 
    FORS_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_ID: Integer;
    FMDO_CODIGO: Integer;
    FORS_HASHKEY: String;
    FORS_COD_TOT_PARC: String;
    FORS_QTDHORAS: Double;
    FORS_VALORISSITEM: Double;
    FORS_VALORSERVICO: Double;
    FORS_VALORDESCTOSERVICO: Double;
    FORS_VALORBASECALCULOISSITEM: Double;
    FORS_VALORLIQUIDOSERVICO: Double;
    FORS_TOTALSERVICO: Double;
    FORS_TOTALISSITEM: Double;
    FORS_TOTALDESCTOSERVICO: Double;
    FORS_TOTALBASECALCULOISSITEM: Double;
    FORS_TOTALLIQUIDOSERVICO: Double;
    FORS_PERCENTUALISSITEM: Double;
    FORS_PERCENTUALDESCTOSERVICO: Double;
    FORS_DATAALTERACAO: TDateTime;
    FMDO_DESCRICAO: String;
    FORS_02_ID_OLD: Integer;
    FORS_ID_OLD: Integer;
  public
    { Public declarations }

    const Table      = 'ORS_00_02';
    const PrimaryKey = 'ORS_02_ID';
    const Sequence   = 'SEQ_ORS_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_02_ID', ftInteger)]
    [Dictionary('ORS_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_02_ID: Integer read FORS_02_ID write FORS_02_ID;
    const ORS_02_ID_Name = 'ORS_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_00_02_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_HASHKEY', ftString, 50)]
    [Dictionary('ORS_HASHKEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HASHKEY: String read FORS_HASHKEY write FORS_HASHKEY;
    const ORS_HASHKEY_Name = 'ORS_HASHKEY';

    [Restrictions([NoValidate])]
    [Column('ORS_COD_TOT_PARC', ftString, 7)]
    [Dictionary('ORS_COD_TOT_PARC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_COD_TOT_PARC: String read FORS_COD_TOT_PARC write FORS_COD_TOT_PARC;
    const ORS_COD_TOT_PARC_Name = 'ORS_COD_TOT_PARC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_QTDHORAS', ftBCD, 5177428, 3)]
    [Dictionary('ORS_QTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_QTDHORAS: Double read FORS_QTDHORAS write FORS_QTDHORAS;
    const ORS_QTDHORAS_Name = 'ORS_QTDHORAS';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORISSITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORISSITEM: Double read FORS_VALORISSITEM write FORS_VALORISSITEM;
    const ORS_VALORISSITEM_Name = 'ORS_VALORISSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_VALORSERVICO', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORSERVICO: Double read FORS_VALORSERVICO write FORS_VALORSERVICO;
    const ORS_VALORSERVICO_Name = 'ORS_VALORSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORDESCTOSERVICO', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORDESCTOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORDESCTOSERVICO: Double read FORS_VALORDESCTOSERVICO write FORS_VALORDESCTOSERVICO;
    const ORS_VALORDESCTOSERVICO_Name = 'ORS_VALORDESCTOSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORBASECALCULOISSITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORBASECALCULOISSITEM: Double read FORS_VALORBASECALCULOISSITEM write FORS_VALORBASECALCULOISSITEM;
    const ORS_VALORBASECALCULOISSITEM_Name = 'ORS_VALORBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORLIQUIDOSERVICO', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORLIQUIDOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORLIQUIDOSERVICO: Double read FORS_VALORLIQUIDOSERVICO write FORS_VALORLIQUIDOSERVICO;
    const ORS_VALORLIQUIDOSERVICO_Name = 'ORS_VALORLIQUIDOSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALSERVICO', ftBCD, 2097184, 2)]
    [Dictionary('ORS_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALSERVICO: Double read FORS_TOTALSERVICO write FORS_TOTALSERVICO;
    const ORS_TOTALSERVICO_Name = 'ORS_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALISSITEM', ftBCD, 6881394, 2)]
    [Dictionary('ORS_TOTALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALISSITEM: Double read FORS_TOTALISSITEM write FORS_TOTALISSITEM;
    const ORS_TOTALISSITEM_Name = 'ORS_TOTALISSITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALDESCTOSERVICO', ftBCD, 4522067, 2)]
    [Dictionary('ORS_TOTALDESCTOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOSERVICO: Double read FORS_TOTALDESCTOSERVICO write FORS_TOTALDESCTOSERVICO;
    const ORS_TOTALDESCTOSERVICO_Name = 'ORS_TOTALDESCTOSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALBASECALCULOISSITEM', ftBCD, 5374017, 2)]
    [Dictionary('ORS_TOTALBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALBASECALCULOISSITEM: Double read FORS_TOTALBASECALCULOISSITEM write FORS_TOTALBASECALCULOISSITEM;
    const ORS_TOTALBASECALCULOISSITEM_Name = 'ORS_TOTALBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALLIQUIDOSERVICO', ftBCD, 5111903, 2)]
    [Dictionary('ORS_TOTALLIQUIDOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALLIQUIDOSERVICO: Double read FORS_TOTALLIQUIDOSERVICO write FORS_TOTALLIQUIDOSERVICO;
    const ORS_TOTALLIQUIDOSERVICO_Name = 'ORS_TOTALLIQUIDOSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALISSITEM', ftBCD, 5374017, 2)]
    [Dictionary('ORS_PERCENTUALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALISSITEM: Double read FORS_PERCENTUALISSITEM write FORS_PERCENTUALISSITEM;
    const ORS_PERCENTUALISSITEM_Name = 'ORS_PERCENTUALISSITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALDESCTOSERVICO', ftBCD, 18, 4)]
    [Dictionary('ORS_PERCENTUALDESCTOSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALDESCTOSERVICO: Double read FORS_PERCENTUALDESCTOSERVICO write FORS_PERCENTUALDESCTOSERVICO;
    const ORS_PERCENTUALDESCTOSERVICO_Name = 'ORS_PERCENTUALDESCTOSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MDO_DESCRICAO', ftString, 100)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('ORS_02_ID_OLD', ftInteger)]
    [Dictionary('ORS_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_02_ID_OLD: Integer read FORS_02_ID_OLD write FORS_02_ID_OLD;
    const ORS_02_ID_OLD_Name = 'ORS_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_00_02)

end.
