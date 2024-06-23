unit express.dbo.LFS_00_01_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfs_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFS_00_01_02', '')]
  [PrimaryKey('LFS_01_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_01_02_ID')]
  TDtoLFS_00_01_02 = class
  private
    { Private declarations } 
    FLFS_01_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_01_ID: Integer;
    FLFS_ID: Integer;
    FMDO_CODIGO: Integer;
    FCST_CODIGO: String;
    FCTB_CODIGO: Integer;
    FCSTPC_CODIGO: String;
    FCFOP_CODIGO: String;
    FLFS_ORDEMITEM: Integer;
    FLFS_QTDHORAS: Double;
    FLFS_VALORSERVICO: Double;
    FLFS_VALORISSITEM: Double;
    FLFS_VALORPISITEM: Double;
    FLFS_VALORCOFINSITEM: Double;
    FLFS_VALORBASECALCULOISSITEM: Double;
    FLFS_VALORBCALCULOPISCOFINSITEM: Double;
    FLFS_PERCENTUALISSITEM: Double;
    FLFS_PERCENTUALCOFINSITEM: Double;
    FLFS_PERCENTUALPISITEM: Double;
    FLFS_TOTALSERVICO: Double;
    FLFS_TOTALISSITEM: Double;
    FLFS_TOTALPISITEM: Double;
    FLFS_TOTALCOFINSITEM: Double;
    FLFS_TOTALBCALCULOPISCOFINSITEM: Double;
    FLFS_TOTALBASECALCULOISSITEM: Double;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_ID_OLD: Integer;
    FLFS_01_ID_OLD: Integer;
    FMDO_DESCRICAO: String;
  public
    { Public declarations }
    const Table      = 'LFS_00_01_02';
    const PrimaryKey = 'LFS_01_02_ID';
    const Sequence   = 'SEQ_LFS_01_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_01_02_ID', ftInteger)]
    [Dictionary('LFS_01_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_02_ID: Integer read FLFS_01_02_ID write FLFS_01_02_ID;
    const LFS_01_02_ID_Name = 'LFS_01_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_01_ID', ftInteger)]
    [Dictionary('LFS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_ID: Integer read FLFS_01_ID write FLFS_01_ID;
    const LFS_01_ID_Name = 'LFS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_01_02_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ORDEMITEM', ftInteger)]
    [Dictionary('LFS_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ORDEMITEM: Integer read FLFS_ORDEMITEM write FLFS_ORDEMITEM;
    const LFS_ORDEMITEM_Name = 'LFS_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_QTDHORAS', ftBCD)]
    [Dictionary('LFS_QTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_QTDHORAS: Double read FLFS_QTDHORAS write FLFS_QTDHORAS;
    const LFS_QTDHORAS_Name = 'LFS_QTDHORAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORSERVICO', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORSERVICO: Double read FLFS_VALORSERVICO write FLFS_VALORSERVICO;
    const LFS_VALORSERVICO_Name = 'LFS_VALORSERVICO';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORISSITEM', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORISSITEM: Double read FLFS_VALORISSITEM write FLFS_VALORISSITEM;
    const LFS_VALORISSITEM_Name = 'LFS_VALORISSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPISITEM: Double read FLFS_VALORPISITEM write FLFS_VALORPISITEM;
    const LFS_VALORPISITEM_Name = 'LFS_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCOFINSITEM: Double read FLFS_VALORCOFINSITEM write FLFS_VALORCOFINSITEM;
    const LFS_VALORCOFINSITEM_Name = 'LFS_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOISSITEM', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOISSITEM: Double read FLFS_VALORBASECALCULOISSITEM write FLFS_VALORBASECALCULOISSITEM;
    const LFS_VALORBASECALCULOISSITEM_Name = 'LFS_VALORBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBCALCULOPISCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBCALCULOPISCOFINSITEM: Double read FLFS_VALORBCALCULOPISCOFINSITEM write FLFS_VALORBCALCULOPISCOFINSITEM;
    const LFS_VALORBCALCULOPISCOFINSITEM_Name = 'LFS_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALISSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALISSITEM: Double read FLFS_PERCENTUALISSITEM write FLFS_PERCENTUALISSITEM;
    const LFS_PERCENTUALISSITEM_Name = 'LFS_PERCENTUALISSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALCOFINSITEM: Double read FLFS_PERCENTUALCOFINSITEM write FLFS_PERCENTUALCOFINSITEM;
    const LFS_PERCENTUALCOFINSITEM_Name = 'LFS_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALPISITEM: Double read FLFS_PERCENTUALPISITEM write FLFS_PERCENTUALPISITEM;
    const LFS_PERCENTUALPISITEM_Name = 'LFS_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALSERVICO', ftBCD)]
    [Dictionary('LFS_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSERVICO: Double read FLFS_TOTALSERVICO write FLFS_TOTALSERVICO;
    const LFS_TOTALSERVICO_Name = 'LFS_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALISSITEM', ftBCD)]
    [Dictionary('LFS_TOTALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALISSITEM: Double read FLFS_TOTALISSITEM write FLFS_TOTALISSITEM;
    const LFS_TOTALISSITEM_Name = 'LFS_TOTALISSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPISITEM', ftBCD)]
    [Dictionary('LFS_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPISITEM: Double read FLFS_TOTALPISITEM write FLFS_TOTALPISITEM;
    const LFS_TOTALPISITEM_Name = 'LFS_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOFINSITEM: Double read FLFS_TOTALCOFINSITEM write FLFS_TOTALCOFINSITEM;
    const LFS_TOTALCOFINSITEM_Name = 'LFS_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBCALCULOPISCOFINSITEM: Double read FLFS_TOTALBCALCULOPISCOFINSITEM write FLFS_TOTALBCALCULOPISCOFINSITEM;
    const LFS_TOTALBCALCULOPISCOFINSITEM_Name = 'LFS_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOISSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOISSITEM: Double read FLFS_TOTALBASECALCULOISSITEM write FLFS_TOTALBASECALCULOISSITEM;
    const LFS_TOTALBASECALCULOISSITEM_Name = 'LFS_TOTALBASECALCULOISSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_01_ID_OLD', ftInteger)]
    [Dictionary('LFS_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_ID_OLD: Integer read FLFS_01_ID_OLD write FLFS_01_ID_OLD;
    const LFS_01_ID_OLD_Name = 'LFS_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_01_02)

end.
