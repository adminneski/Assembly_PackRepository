unit express.dbo.LFE_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfe_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFE_00_03', '')]
  [PrimaryKey('LFE_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFE_03_ID')]
  TDtoLFE_00_03 = class
  private
    { Private declarations } 
    FLFE_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_ID: Integer;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FLFE_VALORITEM: Double;
    FLFE_VALORITEMBRUTO: Double;
    FLFE_VALORPIS: Double;
    FLFE_VALORCOFINS: Double;
    FLFE_VALORBCALCULOPISCOFINS: Double;
    FLFE_PERCENTUALPISITEM: Double;
    FLFE_PERCENTUALCOFINSITEM: Double;
    FLFE_DATAALTERACAO: TDateTime;
    FLFE_03_ID_OLD: Integer;
    FLFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFE_00_03';
    const PrimaryKey = 'LFE_03_ID';
    const Sequence   = 'SEQ_LFE_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_03_ID', ftInteger)]
    [Dictionary('LFE_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_03_ID: Integer read FLFE_03_ID write FLFE_03_ID;
    const LFE_03_ID_Name = 'LFE_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [ForeignKey('LFE_00_03_fk', 'LFE_ID', 'LFE_00', 'LFE_ID', SetNull, SetNull)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

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
    [Column('LFE_VALORITEM', ftBCD)]
    [Dictionary('LFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEM: Double read FLFE_VALORITEM write FLFE_VALORITEM;
    const LFE_VALORITEM_Name = 'LFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORITEMBRUTO', ftBCD)]
    [Dictionary('LFE_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEMBRUTO: Double read FLFE_VALORITEMBRUTO write FLFE_VALORITEMBRUTO;
    const LFE_VALORITEMBRUTO_Name = 'LFE_VALORITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORPIS', ftBCD)]
    [Dictionary('LFE_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORPIS: Double read FLFE_VALORPIS write FLFE_VALORPIS;
    const LFE_VALORPIS_Name = 'LFE_VALORPIS';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORCOFINS', ftBCD)]
    [Dictionary('LFE_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORCOFINS: Double read FLFE_VALORCOFINS write FLFE_VALORCOFINS;
    const LFE_VALORCOFINS_Name = 'LFE_VALORCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFE_VALORBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBCALCULOPISCOFINS: Double read FLFE_VALORBCALCULOPISCOFINS write FLFE_VALORBCALCULOPISCOFINS;
    const LFE_VALORBCALCULOPISCOFINS_Name = 'LFE_VALORBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALPISITEM', ftBCD)]
    [Dictionary('LFE_PERCENTUALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALPISITEM: Double read FLFE_PERCENTUALPISITEM write FLFE_PERCENTUALPISITEM;
    const LFE_PERCENTUALPISITEM_Name = 'LFE_PERCENTUALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_PERCENTUALCOFINSITEM', ftBCD)]
    [Dictionary('LFE_PERCENTUALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALCOFINSITEM: Double read FLFE_PERCENTUALCOFINSITEM write FLFE_PERCENTUALCOFINSITEM;
    const LFE_PERCENTUALCOFINSITEM_Name = 'LFE_PERCENTUALCOFINSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAALTERACAO: TDateTime read FLFE_DATAALTERACAO write FLFE_DATAALTERACAO;
    const LFE_DATAALTERACAO_Name = 'LFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_03_ID_OLD', ftInteger)]
    [Dictionary('LFE_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_03_ID_OLD: Integer read FLFE_03_ID_OLD write FLFE_03_ID_OLD;
    const LFE_03_ID_OLD_Name = 'LFE_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFE_ID_OLD', ftInteger)]
    [Dictionary('LFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID_OLD: Integer read FLFE_ID_OLD write FLFE_ID_OLD;
    const LFE_ID_OLD_Name = 'LFE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFE_00_03)

end.
