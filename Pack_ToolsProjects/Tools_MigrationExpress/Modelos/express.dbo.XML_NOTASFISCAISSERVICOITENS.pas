unit express.dbo.XML_NOTASFISCAISSERVICOITENS;

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
  [Table('XML_NOTASFISCAISSERVICOITENS', '')]
  TDtoXML_NOTASFISCAISSERVICOITENS = class
  private
    { Private declarations } 
    FNFS_RPS: Integer;
    FNFS_01_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFS_01_ID: Integer;
    FNFS_ID: Integer;
    FMDO_CODIGO: Integer;
    FMDO_DESCRICAO: String;
    FMDO_CODIGOCNAE: String;
    FCST_CODIGO: String;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNFS_ORDEMITEM: Integer;
    FNFS_QTDHORAS: Double;
    FNFS_VALORSERVICO: Double;
    FNFS_TOTALSERVICO: Double;
    FNFS_VALORBASECALCULOISSITEM: Double;
    FNFS_PERCENTUALISSITEM: Double;
    FNFS_VALORISSITEM: Double;
    FNFS_DATAALTERACAO: TDateTime;
    FNFS_PERCENTUALCOFINSITEM: Double;
    FNFS_PERCENTUALPISITEM: Double;
    FLFS_VALORBCALCULOPISCOFINSITEM: Double;
    FNFS_VALORCOFINSITEM: Double;
    FNFS_VALORPISITEM: Double;
    FCSTPC_CODIGO: String;
    FNFS_TOTALBASECALCULOISSITEM: Double;
    FNFS_TOTALISSITEM: Double;
    FLFS_TOTALBCALCULOPISCOFINSITEM: Double;
    FNFS_TOTALCOFINSITEM: Double;
    FNFS_TOTALPISITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'XML_NOTASFISCAISSERVICOITENS';

    [Restrictions([NoValidate])]
    [Column('NFS_RPS', ftInteger)]
    [Dictionary('NFS_RPS', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_RPS: Integer read FNFS_RPS write FNFS_RPS;
    const NFS_RPS_Name = 'NFS_RPS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_01_02_ID', ftInteger)]
    [Dictionary('NFS_01_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_01_02_ID: Integer read FNFS_01_02_ID write FNFS_01_02_ID;
    const NFS_01_02_ID_Name = 'NFS_01_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_01_ID', ftInteger)]
    [Dictionary('NFS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_01_ID: Integer read FNFS_01_ID write FNFS_01_ID;
    const NFS_01_ID_Name = 'NFS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_ID', ftInteger)]
    [Dictionary('NFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_ID: Integer read FNFS_ID write FNFS_ID;
    const NFS_ID_Name = 'NFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGOCNAE', ftString, 20)]
    [Dictionary('MDO_CODIGOCNAE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_CODIGOCNAE: String read FMDO_CODIGOCNAE write FMDO_CODIGOCNAE;
    const MDO_CODIGOCNAE_Name = 'MDO_CODIGOCNAE';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_ORDEMITEM', ftInteger)]
    [Dictionary('NFS_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFS_ORDEMITEM: Integer read FNFS_ORDEMITEM write FNFS_ORDEMITEM;
    const NFS_ORDEMITEM_Name = 'NFS_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_QTDHORAS', ftBCD, 48, 3)]
    [Dictionary('NFS_QTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_QTDHORAS: Double read FNFS_QTDHORAS write FNFS_QTDHORAS;
    const NFS_QTDHORAS_Name = 'NFS_QTDHORAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_VALORSERVICO', ftBCD, 18, 4)]
    [Dictionary('NFS_VALORSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_VALORSERVICO: Double read FNFS_VALORSERVICO write FNFS_VALORSERVICO;
    const NFS_VALORSERVICO_Name = 'NFS_VALORSERVICO';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALSERVICO', ftBCD, 10, 7)]
    [Dictionary('NFS_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALSERVICO: Double read FNFS_TOTALSERVICO write FNFS_TOTALSERVICO;
    const NFS_TOTALSERVICO_Name = 'NFS_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('NFS_VALORBASECALCULOISSITEM', ftBCD, 18, 4)]
    [Dictionary('NFS_VALORBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_VALORBASECALCULOISSITEM: Double read FNFS_VALORBASECALCULOISSITEM write FNFS_VALORBASECALCULOISSITEM;
    const NFS_VALORBASECALCULOISSITEM_Name = 'NFS_VALORBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_PERCENTUALISSITEM', ftBCD)]
    [Dictionary('NFS_PERCENTUALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_PERCENTUALISSITEM: Double read FNFS_PERCENTUALISSITEM write FNFS_PERCENTUALISSITEM;
    const NFS_PERCENTUALISSITEM_Name = 'NFS_PERCENTUALISSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_VALORISSITEM', ftBCD, 18, 4)]
    [Dictionary('NFS_VALORISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_VALORISSITEM: Double read FNFS_VALORISSITEM write FNFS_VALORISSITEM;
    const NFS_VALORISSITEM_Name = 'NFS_VALORISSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFS_DATAALTERACAO: TDateTime read FNFS_DATAALTERACAO write FNFS_DATAALTERACAO;
    const NFS_DATAALTERACAO_Name = 'NFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFS_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('NFS_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_PERCENTUALCOFINSITEM: Double read FNFS_PERCENTUALCOFINSITEM write FNFS_PERCENTUALCOFINSITEM;
    const NFS_PERCENTUALCOFINSITEM_Name = 'NFS_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('NFS_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_PERCENTUALPISITEM: Double read FNFS_PERCENTUALPISITEM write FNFS_PERCENTUALPISITEM;
    const NFS_PERCENTUALPISITEM_Name = 'NFS_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBCALCULOPISCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('LFS_VALORBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBCALCULOPISCOFINSITEM: Double read FLFS_VALORBCALCULOPISCOFINSITEM write FLFS_VALORBCALCULOPISCOFINSITEM;
    const LFS_VALORBCALCULOPISCOFINSITEM_Name = 'LFS_VALORBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_VALORCOFINSITEM', ftBCD, 18, 4)]
    [Dictionary('NFS_VALORCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_VALORCOFINSITEM: Double read FNFS_VALORCOFINSITEM write FNFS_VALORCOFINSITEM;
    const NFS_VALORCOFINSITEM_Name = 'NFS_VALORCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_VALORPISITEM', ftBCD, 18, 4)]
    [Dictionary('NFS_VALORPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_VALORPISITEM: Double read FNFS_VALORPISITEM write FNFS_VALORPISITEM;
    const NFS_VALORPISITEM_Name = 'NFS_VALORPISITEM';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALBASECALCULOISSITEM', ftBCD)]
    [Dictionary('NFS_TOTALBASECALCULOISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALBASECALCULOISSITEM: Double read FNFS_TOTALBASECALCULOISSITEM write FNFS_TOTALBASECALCULOISSITEM;
    const NFS_TOTALBASECALCULOISSITEM_Name = 'NFS_TOTALBASECALCULOISSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALISSITEM', ftBCD)]
    [Dictionary('NFS_TOTALISSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALISSITEM: Double read FNFS_TOTALISSITEM write FNFS_TOTALISSITEM;
    const NFS_TOTALISSITEM_Name = 'NFS_TOTALISSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBCALCULOPISCOFINSITEM: Double read FLFS_TOTALBCALCULOPISCOFINSITEM write FLFS_TOTALBCALCULOPISCOFINSITEM;
    const LFS_TOTALBCALCULOPISCOFINSITEM_Name = 'LFS_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('NFS_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALCOFINSITEM: Double read FNFS_TOTALCOFINSITEM write FNFS_TOTALCOFINSITEM;
    const NFS_TOTALCOFINSITEM_Name = 'NFS_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('NFS_TOTALPISITEM', ftBCD, 48, 2)]
    [Dictionary('NFS_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFS_TOTALPISITEM: Double read FNFS_TOTALPISITEM write FNFS_TOTALPISITEM;
    const NFS_TOTALPISITEM_Name = 'NFS_TOTALPISITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_NOTASFISCAISSERVICOITENS)

end.
