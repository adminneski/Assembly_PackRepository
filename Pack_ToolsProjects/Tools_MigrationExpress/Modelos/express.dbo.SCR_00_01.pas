unit express.dbo.SCR_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.scr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('SCR_00_01', '')]
  [PrimaryKey('SCR_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCR_01_ID')]
  TDtoSCR_00_01 = class
  private
    { Private declarations } 
    FSCR_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCR_ID: Integer;
    FCRE_ID: Integer;
    FCRE_DATAVENCTOVELHO: TDateTime;
    FCRE_DATAVENCTONOVO: TDateTime;
    FCRE_TIPODOCUMENTO: String;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_PERCENTUALJUROS: Double;
    FCRE_TOTALSUBSTITUIDO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_TOTALBASECOMISSAO: Double;
    FCRE_PERCENTUALCOMISSAO: Double;
    FCRE_TOTALCOMISSAO: Double;
    FSCR_DATAALTERACAO: TDateTime;
    FSCR_01_ID_OLD: Integer;
    FSCR_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'SCR_00_01';
    const PrimaryKey = 'SCR_01_ID';
    const Sequence   = 'SEQ_SCR_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_01_ID', ftInteger)]
    [Dictionary('SCR_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_01_ID: Integer read FSCR_01_ID write FSCR_01_ID;
    const SCR_01_ID_Name = 'SCR_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [ForeignKey('SCR_00_01_fk', 'SCR_ID', 'SCR_00', 'SCR_ID', SetNull, SetNull)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTOVELHO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOVELHO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTOVELHO: TDateTime read FCRE_DATAVENCTOVELHO write FCRE_DATAVENCTOVELHO;
    const CRE_DATAVENCTOVELHO_Name = 'CRE_DATAVENCTOVELHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTONOVO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTONOVO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTONOVO: TDateTime read FCRE_DATAVENCTONOVO write FCRE_DATAVENCTONOVO;
    const CRE_DATAVENCTONOVO_Name = 'CRE_DATAVENCTONOVO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD, 1380275039, 2)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROS', ftBCD, 6881394, 2)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTA', ftBCD, 656419879, 2)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTO', ftBCD, 1146045279, 2)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIO', ftBCD, 2097273, 2)]
    [Dictionary('CRE_TOTALCARTORIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIO: Double read FCRE_TOTALCARTORIO write FCRE_TOTALCARTORIO;
    const CRE_TOTALCARTORIO_Name = 'CRE_TOTALCARTORIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALJUROS', ftBCD, 4456531, 2)]
    [Dictionary('CRE_PERCENTUALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALJUROS: Double read FCRE_PERCENTUALJUROS write FCRE_PERCENTUALJUROS;
    const CRE_PERCENTUALJUROS_Name = 'CRE_PERCENTUALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALSUBSTITUIDO', ftBCD, 1195983951, 2)]
    [Dictionary('CRE_TOTALSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALSUBSTITUIDO: Double read FCRE_TOTALSUBSTITUIDO write FCRE_TOTALSUBSTITUIDO;
    const CRE_TOTALSUBSTITUIDO_Name = 'CRE_TOTALSUBSTITUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESAS', ftBCD, 1397311055, 2)]
    [Dictionary('CRE_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESAS: Double read FCRE_TOTALOUTRASDESPESAS write FCRE_TOTALOUTRASDESPESAS;
    const CRE_TOTALOUTRASDESPESAS_Name = 'CRE_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALBASECOMISSAO', ftBCD, 218762555, 2)]
    [Dictionary('CRE_TOTALBASECOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALBASECOMISSAO: Double read FCRE_TOTALBASECOMISSAO write FCRE_TOTALBASECOMISSAO;
    const CRE_TOTALBASECOMISSAO_Name = 'CRE_TOTALBASECOMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALCOMISSAO', ftBCD, 1952672068, 2)]
    [Dictionary('CRE_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALCOMISSAO: Double read FCRE_PERCENTUALCOMISSAO write FCRE_PERCENTUALCOMISSAO;
    const CRE_PERCENTUALCOMISSAO_Name = 'CRE_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALCOMISSAO', ftBCD, 537529693, 2)]
    [Dictionary('CRE_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCOMISSAO: Double read FCRE_TOTALCOMISSAO write FCRE_TOTALCOMISSAO;
    const CRE_TOTALCOMISSAO_Name = 'CRE_TOTALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAALTERACAO: TDateTime read FSCR_DATAALTERACAO write FSCR_DATAALTERACAO;
    const SCR_DATAALTERACAO_Name = 'SCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCR_01_ID_OLD', ftInteger)]
    [Dictionary('SCR_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_01_ID_OLD: Integer read FSCR_01_ID_OLD write FSCR_01_ID_OLD;
    const SCR_01_ID_OLD_Name = 'SCR_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('SCR_ID_OLD', ftInteger)]
    [Dictionary('SCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID_OLD: Integer read FSCR_ID_OLD write FSCR_ID_OLD;
    const SCR_ID_OLD_Name = 'SCR_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCR_00_01)

end.
