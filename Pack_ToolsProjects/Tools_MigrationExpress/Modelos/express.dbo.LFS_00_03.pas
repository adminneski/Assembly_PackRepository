unit express.dbo.LFS_00_03;

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
  [Table('LFS_00_03', '')]
  [PrimaryKey('LFS_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_03_ID')]
  TDtoLFS_00_03 = class
  private
    { Private declarations } 
    FLFS_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FLFS_VALORITEM: Double;
    FLFS_VALORITEMBRUTO: Double;
    FLFS_VALORBCALCULOPISCOFINS: Double;
    FLFS_VALORPIS: Double;
    FLFS_VALORCOFINS: Double;
    FLFS_PERCENTUALPISITEM: Double;
    FLFS_PERCENTUALCOFINSITEM: Double;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_03_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_03';
    const PrimaryKey = 'LFS_03_ID';
    const Sequence   = 'SEQ_LFS_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_03_ID', ftInteger)]
    [Dictionary('LFS_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_03_ID: Integer read FLFS_03_ID write FLFS_03_ID;
    const LFS_03_ID_Name = 'LFS_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_03_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORITEM', ftBCD)]
    [Dictionary('LFS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEM: Double read FLFS_VALORITEM write FLFS_VALORITEM;
    const LFS_VALORITEM_Name = 'LFS_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORITEMBRUTO', ftBCD)]
    [Dictionary('LFS_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEMBRUTO: Double read FLFS_VALORITEMBRUTO write FLFS_VALORITEMBRUTO;
    const LFS_VALORITEMBRUTO_Name = 'LFS_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFS_VALORBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBCALCULOPISCOFINS: Double read FLFS_VALORBCALCULOPISCOFINS write FLFS_VALORBCALCULOPISCOFINS;
    const LFS_VALORBCALCULOPISCOFINS_Name = 'LFS_VALORBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPIS', ftBCD)]
    [Dictionary('LFS_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPIS: Double read FLFS_VALORPIS write FLFS_VALORPIS;
    const LFS_VALORPIS_Name = 'LFS_VALORPIS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCOFINS', ftBCD)]
    [Dictionary('LFS_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCOFINS: Double read FLFS_VALORCOFINS write FLFS_VALORCOFINS;
    const LFS_VALORCOFINS_Name = 'LFS_VALORCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALPISITEM: Double read FLFS_PERCENTUALPISITEM write FLFS_PERCENTUALPISITEM;
    const LFS_PERCENTUALPISITEM_Name = 'LFS_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALCOFINSITEM: Double read FLFS_PERCENTUALCOFINSITEM write FLFS_PERCENTUALCOFINSITEM;
    const LFS_PERCENTUALCOFINSITEM_Name = 'LFS_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_03_ID_OLD', ftInteger)]
    [Dictionary('LFS_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_03_ID_OLD: Integer read FLFS_03_ID_OLD write FLFS_03_ID_OLD;
    const LFS_03_ID_OLD_Name = 'LFS_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_03)

end.
