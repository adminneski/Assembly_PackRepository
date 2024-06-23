unit express.dbo.LFE_00_01;

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
  [Table('LFE_00_01', '')]
  [PrimaryKey('LFE_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFE_01_ID')]
  TDtoLFE_00_01 = class
  private
    { Private declarations } 
    FLFE_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_ID: Integer;
    FGAI_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FCST_CODIGO: String;
    FCFOP_CODIGO: String;
    FCTB_CODIGO: Integer;
    FLFE_VALORITEM: Double;
    FLFE_VALORITEMBRUTO: Double;
    FLFE_VALORIPI: Double;
    FLFE_VALORPIS: Double;
    FLFE_VALORCOFINS: Double;
    FLFE_VALORICMS: Double;
    FLFE_VALORFRETENF: Double;
    FLFE_VALORICMSRNF: Double;
    FLFE_VALORBASEOUTROS: Double;
    FLFE_VALORDESPACESSORIA: Double;
    FLFE_VALORBASEISENTOICMS: Double;
    FLFE_VALORBASECALCULOICMS: Double;
    FLFE_VALORBASECALCULOMVA: Double;
    FLFE_VALORBCALCULOPISCOFINS: Double;
    FLFE_PERCENTUALICMS: Double;
    FLFE_DATAALTERACAO: TDateTime;
    FLFE_01_ID_OLD: Integer;
    FLFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFE_00_01';
    const PrimaryKey = 'LFE_01_ID';
    const Sequence   = 'SEQ_LFE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_01_ID', ftInteger)]
    [Dictionary('LFE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_01_ID: Integer read FLFE_01_ID write FLFE_01_ID;
    const LFE_01_ID_Name = 'LFE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [ForeignKey('LFE_00_01_fk', 'LFE_ID', 'LFE_00', 'LFE_ID', SetNull, SetNull)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

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
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

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
    [Column('LFE_VALORITEM', ftBCD)]
    [Dictionary('LFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEM: Double read FLFE_VALORITEM write FLFE_VALORITEM;
    const LFE_VALORITEM_Name = 'LFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORITEMBRUTO', ftBCD)]
    [Dictionary('LFE_VALORITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEMBRUTO: Double read FLFE_VALORITEMBRUTO write FLFE_VALORITEMBRUTO;
    const LFE_VALORITEMBRUTO_Name = 'LFE_VALORITEMBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORIPI', ftBCD)]
    [Dictionary('LFE_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORIPI: Double read FLFE_VALORIPI write FLFE_VALORIPI;
    const LFE_VALORIPI_Name = 'LFE_VALORIPI';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORICMS', ftBCD)]
    [Dictionary('LFE_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMS: Double read FLFE_VALORICMS write FLFE_VALORICMS;
    const LFE_VALORICMS_Name = 'LFE_VALORICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORFRETENF', ftBCD)]
    [Dictionary('LFE_VALORFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORFRETENF: Double read FLFE_VALORFRETENF write FLFE_VALORFRETENF;
    const LFE_VALORFRETENF_Name = 'LFE_VALORFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORICMSRNF', ftBCD)]
    [Dictionary('LFE_VALORICMSRNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORICMSRNF: Double read FLFE_VALORICMSRNF write FLFE_VALORICMSRNF;
    const LFE_VALORICMSRNF_Name = 'LFE_VALORICMSRNF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASEOUTROS', ftBCD)]
    [Dictionary('LFE_VALORBASEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEOUTROS: Double read FLFE_VALORBASEOUTROS write FLFE_VALORBASEOUTROS;
    const LFE_VALORBASEOUTROS_Name = 'LFE_VALORBASEOUTROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORDESPACESSORIA', ftBCD)]
    [Dictionary('LFE_VALORDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORDESPACESSORIA: Double read FLFE_VALORDESPACESSORIA write FLFE_VALORDESPACESSORIA;
    const LFE_VALORDESPACESSORIA_Name = 'LFE_VALORDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASEISENTOICMS', ftBCD)]
    [Dictionary('LFE_VALORBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEISENTOICMS: Double read FLFE_VALORBASEISENTOICMS write FLFE_VALORBASEISENTOICMS;
    const LFE_VALORBASEISENTOICMS_Name = 'LFE_VALORBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASECALCULOICMS', ftBCD)]
    [Dictionary('LFE_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOICMS: Double read FLFE_VALORBASECALCULOICMS write FLFE_VALORBASECALCULOICMS;
    const LFE_VALORBASECALCULOICMS_Name = 'LFE_VALORBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASECALCULOMVA', ftBCD)]
    [Dictionary('LFE_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASECALCULOMVA: Double read FLFE_VALORBASECALCULOMVA write FLFE_VALORBASECALCULOMVA;
    const LFE_VALORBASECALCULOMVA_Name = 'LFE_VALORBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFE_VALORBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBCALCULOPISCOFINS: Double read FLFE_VALORBCALCULOPISCOFINS write FLFE_VALORBCALCULOPISCOFINS;
    const LFE_VALORBCALCULOPISCOFINS_Name = 'LFE_VALORBCALCULOPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_PERCENTUALICMS', ftBCD)]
    [Dictionary('LFE_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_PERCENTUALICMS: Double read FLFE_PERCENTUALICMS write FLFE_PERCENTUALICMS;
    const LFE_PERCENTUALICMS_Name = 'LFE_PERCENTUALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAALTERACAO: TDateTime read FLFE_DATAALTERACAO write FLFE_DATAALTERACAO;
    const LFE_DATAALTERACAO_Name = 'LFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_01_ID_OLD', ftInteger)]
    [Dictionary('LFE_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_01_ID_OLD: Integer read FLFE_01_ID_OLD write FLFE_01_ID_OLD;
    const LFE_01_ID_OLD_Name = 'LFE_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFE_ID_OLD', ftInteger)]
    [Dictionary('LFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID_OLD: Integer read FLFE_ID_OLD write FLFE_ID_OLD;
    const LFE_ID_OLD_Name = 'LFE_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoLFE_00_01)

end.
