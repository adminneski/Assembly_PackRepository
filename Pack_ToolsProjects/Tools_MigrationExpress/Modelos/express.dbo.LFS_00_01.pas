unit express.dbo.LFS_00_01;

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
  [Table('LFS_00_01', '')]
  [PrimaryKey('LFS_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_01_ID')]
  TDtoLFS_00_01 = class
  private
    { Private declarations } 
    FLFS_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FGAI_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCTB_CODIGO: Integer;
    FLFS_VALORITEM: Double;
    FLFS_VALORITEMBRUTO: Double;
    FLFS_VALORIPI: Double;
    FLFS_VALORISS: Double;
    FLFS_VALORICMS: Double;
    FLFS_VALORPIS: Double;
    FLFS_VALORCOFINS: Double;
    FLFS_VALORICMSRNF: Double;
    FLFS_VALORFRETENF: Double;
    FLFS_VALORBASEOUTROS: Double;
    FLFS_VALORDESPACESSORIA: Double;
    FLFS_VALORBASEISENTOICMS: Double;
    FLFS_VALORBASECALCULOICMS: Double;
    FLFS_VALORBASECALCULOMVA: Double;
    FLFS_VALORBASECALCULOISS: Double;
    FLFS_VALORBCALCULOPISCOFINS: Double;
    FLFS_PERCENTUALISS: Double;
    FLFS_PERCENTUALICMS: Double;
    FLFS_NUMEROORDEMCOMPRA: String;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_01_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
    FLFS_VALORIR: Double;
    FLFS_VALORCSLL: Double;
    FLFS_PERCENTUALIR: Double;
    FLFS_PERCENTUALCSLL: Double;
  public
    { Public declarations }
    const Table      = 'LFS_00_01';
    const PrimaryKey = 'LFS_01_ID';
    const Sequence   = 'SEQ_LFS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_01_ID', ftInteger)]
    [Dictionary('LFS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_ID: Integer read FLFS_01_ID write FLFS_01_ID;
    const LFS_01_ID_Name = 'LFS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_01_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORIPI', ftBCD)]
    [Dictionary('LFS_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORIPI: Double read FLFS_VALORIPI write FLFS_VALORIPI;
    const LFS_VALORIPI_Name = 'LFS_VALORIPI';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORISS', ftBCD)]
    [Dictionary('LFS_VALORISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORISS: Double read FLFS_VALORISS write FLFS_VALORISS;
    const LFS_VALORISS_Name = 'LFS_VALORISS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORICMS', ftBCD)]
    [Dictionary('LFS_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMS: Double read FLFS_VALORICMS write FLFS_VALORICMS;
    const LFS_VALORICMS_Name = 'LFS_VALORICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPIS', ftBCD, 66256176, 2)]
    [Dictionary('LFS_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPIS: Double read FLFS_VALORPIS write FLFS_VALORPIS;
    const LFS_VALORPIS_Name = 'LFS_VALORPIS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCOFINS', ftBCD)]
    [Dictionary('LFS_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCOFINS: Double read FLFS_VALORCOFINS write FLFS_VALORCOFINS;
    const LFS_VALORCOFINS_Name = 'LFS_VALORCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORICMSRNF', ftBCD, 1650, 2)]
    [Dictionary('LFS_VALORICMSRNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSRNF: Double read FLFS_VALORICMSRNF write FLFS_VALORICMSRNF;
    const LFS_VALORICMSRNF_Name = 'LFS_VALORICMSRNF';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORFRETENF', ftBCD)]
    [Dictionary('LFS_VALORFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORFRETENF: Double read FLFS_VALORFRETENF write FLFS_VALORFRETENF;
    const LFS_VALORFRETENF_Name = 'LFS_VALORFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASEOUTROS', ftBCD)]
    [Dictionary('LFS_VALORBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEOUTROS: Double read FLFS_VALORBASEOUTROS write FLFS_VALORBASEOUTROS;
    const LFS_VALORBASEOUTROS_Name = 'LFS_VALORBASEOUTROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORDESPACESSORIA', ftBCD)]
    [Dictionary('LFS_VALORDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDESPACESSORIA: Double read FLFS_VALORDESPACESSORIA write FLFS_VALORDESPACESSORIA;
    const LFS_VALORDESPACESSORIA_Name = 'LFS_VALORDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASEISENTOICMS', ftBCD)]
    [Dictionary('LFS_VALORBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEISENTOICMS: Double read FLFS_VALORBASEISENTOICMS write FLFS_VALORBASEISENTOICMS;
    const LFS_VALORBASEISENTOICMS_Name = 'LFS_VALORBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASECALCULOICMS', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMS: Double read FLFS_VALORBASECALCULOICMS write FLFS_VALORBASECALCULOICMS;
    const LFS_VALORBASECALCULOICMS_Name = 'LFS_VALORBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASECALCULOMVA', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOMVA: Double read FLFS_VALORBASECALCULOMVA write FLFS_VALORBASECALCULOMVA;
    const LFS_VALORBASECALCULOMVA_Name = 'LFS_VALORBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOISS', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOISS: Double read FLFS_VALORBASECALCULOISS write FLFS_VALORBASECALCULOISS;
    const LFS_VALORBASECALCULOISS_Name = 'LFS_VALORBASECALCULOISS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFS_VALORBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBCALCULOPISCOFINS: Double read FLFS_VALORBCALCULOPISCOFINS write FLFS_VALORBCALCULOPISCOFINS;
    const LFS_VALORBCALCULOPISCOFINS_Name = 'LFS_VALORBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALISS', ftBCD)]
    [Dictionary('LFS_PERCENTUALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALISS: Double read FLFS_PERCENTUALISS write FLFS_PERCENTUALISS;
    const LFS_PERCENTUALISS_Name = 'LFS_PERCENTUALISS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_PERCENTUALICMS', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMS: Double read FLFS_PERCENTUALICMS write FLFS_PERCENTUALICMS;
    const LFS_PERCENTUALICMS_Name = 'LFS_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('LFS_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROORDEMCOMPRA: String read FLFS_NUMEROORDEMCOMPRA write FLFS_NUMEROORDEMCOMPRA;
    const LFS_NUMEROORDEMCOMPRA_Name = 'LFS_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_01_ID_OLD', ftInteger)]
    [Dictionary('LFS_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_01_ID_OLD: Integer read FLFS_01_ID_OLD write FLFS_01_ID_OLD;
    const LFS_01_ID_OLD_Name = 'LFS_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORIR', ftBCD)]
    [Dictionary('LFS_VALORIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORIR: Double read FLFS_VALORIR write FLFS_VALORIR;
    const LFS_VALORIR_Name = 'LFS_VALORIR';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCSLL', ftBCD)]
    [Dictionary('LFS_VALORCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCSLL: Double read FLFS_VALORCSLL write FLFS_VALORCSLL;
    const LFS_VALORCSLL_Name = 'LFS_VALORCSLL';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALIR', ftBCD)]
    [Dictionary('LFS_PERCENTUALIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALIR: Double read FLFS_PERCENTUALIR write FLFS_PERCENTUALIR;
    const LFS_PERCENTUALIR_Name = 'LFS_PERCENTUALIR';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALCSLL', ftBCD)]
    [Dictionary('LFS_PERCENTUALCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALCSLL: Double read FLFS_PERCENTUALCSLL write FLFS_PERCENTUALCSLL;
    const LFS_PERCENTUALCSLL_Name = 'LFS_PERCENTUALCSLL';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_01)

end.
