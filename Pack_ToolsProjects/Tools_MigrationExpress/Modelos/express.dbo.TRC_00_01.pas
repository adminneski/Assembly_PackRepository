unit express.dbo.TRC_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.trc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('TRC_00_01', '')]
  [PrimaryKey('TRC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TRC_01_ID')]
  TDtoTRC_00_01 = class
  private
    { Private declarations } 
    FTRC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRC_ID: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FTRC_QTDTROCADA: Double;
    FTRC_PRECOCUSTO: Double;
    FTRC_PRECOLIQUIDO: Double;
    FTRC_PRECODIGITADO: Double;
    FTRC_VALORDESCTOITEM: Double;
    FTRC_PERCENTUALDESCTOITEM: Double;
    FTRC_DATAALTERACAO: TDateTime;
    FTRC_01_ID_OLD: Integer;
    FTRC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'TRC_00_01';
    const PrimaryKey = 'TRC_01_ID';
    const Sequence   = 'SEQ_TRC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_01_ID', ftInteger)]
    [Dictionary('TRC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_01_ID: Integer read FTRC_01_ID write FTRC_01_ID;
    const TRC_01_ID_Name = 'TRC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_ID', ftInteger)]
    [ForeignKey('TRC_00_01_fk', 'TRC_ID', 'TRC_00', 'TRC_ID', SetNull, SetNull)]
    [Dictionary('TRC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_ID: Integer read FTRC_ID write FTRC_ID;
    const TRC_ID_Name = 'TRC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_QTDTROCADA', ftBCD, 18, 4)]
    [Dictionary('TRC_QTDTROCADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_QTDTROCADA: Double read FTRC_QTDTROCADA write FTRC_QTDTROCADA;
    const TRC_QTDTROCADA_Name = 'TRC_QTDTROCADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_PRECOCUSTO', ftBCD, 1952531540, 2)]
    [Dictionary('TRC_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_PRECOCUSTO: Double read FTRC_PRECOCUSTO write FTRC_PRECOCUSTO;
    const TRC_PRECOCUSTO_Name = 'TRC_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_PRECOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('TRC_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_PRECOLIQUIDO: Double read FTRC_PRECOLIQUIDO write FTRC_PRECOLIQUIDO;
    const TRC_PRECOLIQUIDO_Name = 'TRC_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_PRECODIGITADO', ftBCD, 18, 4)]
    [Dictionary('TRC_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_PRECODIGITADO: Double read FTRC_PRECODIGITADO write FTRC_PRECODIGITADO;
    const TRC_PRECODIGITADO_Name = 'TRC_PRECODIGITADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('TRC_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_VALORDESCTOITEM: Double read FTRC_VALORDESCTOITEM write FTRC_VALORDESCTOITEM;
    const TRC_VALORDESCTOITEM_Name = 'TRC_VALORDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('TRC_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_PERCENTUALDESCTOITEM: Double read FTRC_PERCENTUALDESCTOITEM write FTRC_PERCENTUALDESCTOITEM;
    const TRC_PERCENTUALDESCTOITEM_Name = 'TRC_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_DATAALTERACAO', ftDateTime)]
    [Dictionary('TRC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TRC_DATAALTERACAO: TDateTime read FTRC_DATAALTERACAO write FTRC_DATAALTERACAO;
    const TRC_DATAALTERACAO_Name = 'TRC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('TRC_01_ID_OLD', ftInteger)]
    [Dictionary('TRC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_01_ID_OLD: Integer read FTRC_01_ID_OLD write FTRC_01_ID_OLD;
    const TRC_01_ID_OLD_Name = 'TRC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('TRC_ID_OLD', ftInteger)]
    [Dictionary('TRC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_ID_OLD: Integer read FTRC_ID_OLD write FTRC_ID_OLD;
    const TRC_ID_OLD_Name = 'TRC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTRC_00_01)

end.
