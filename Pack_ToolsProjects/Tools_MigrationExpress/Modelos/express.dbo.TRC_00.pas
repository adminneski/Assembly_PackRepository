unit express.dbo.TRC_00;

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
  [Table('TRC_00', '')]
  [PrimaryKey('TRC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TRC_ID')]
  TDtoTRC_00 = class
  private
    { Private declarations } 
    FTRC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FTRC_NUMERODOCTO: String;
    FTRC_DATALANCAMENTO: TDateTime;
    FTRC_DATACANCELAMENTO: TDateTime;
    FTRC_OBSERVACAOCANCELAMENTO: String;
    FTRC_TOTALDESCTOITEM: Double;
    FTRC_TOTALLIQUIDO: Double;
    FTRC_TOTALPRODUTOS: Double;
    FTRC_TOTALPESOBRUTO: Double;
    FTRC_TOTALPESOLIQUIDO: Double;
    FTRC_TOTALQTDTROCADA: Double;
    FTRC_OBSERVACAO: String;
    FTRC_CANCELADA: String;
    FTRC_PROCESSADO: String;
    FTRC_DATAALTERACAO: TDateTime;
    FTRC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'TRC_00';
     const PrimaryKey = 'TRC_ID';
     const Sequence   = 'SEQ_TRC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_ID', ftInteger)]
    [Dictionary('TRC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_ID: Integer read FTRC_ID write FTRC_ID;
    const TRC_ID_Name = 'TRC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_NUMERODOCTO', ftString, 10)]
    [Dictionary('TRC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_NUMERODOCTO: String read FTRC_NUMERODOCTO write FTRC_NUMERODOCTO;
    const TRC_NUMERODOCTO_Name = 'TRC_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('TRC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TRC_DATALANCAMENTO: TDateTime read FTRC_DATALANCAMENTO write FTRC_DATALANCAMENTO;
    const TRC_DATALANCAMENTO_Name = 'TRC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('TRC_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('TRC_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property TRC_DATACANCELAMENTO: TDateTime read FTRC_DATACANCELAMENTO write FTRC_DATACANCELAMENTO;
    const TRC_DATACANCELAMENTO_Name = 'TRC_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('TRC_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('TRC_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_OBSERVACAOCANCELAMENTO: String read FTRC_OBSERVACAOCANCELAMENTO write FTRC_OBSERVACAOCANCELAMENTO;
    const TRC_OBSERVACAOCANCELAMENTO_Name = 'TRC_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALDESCTOITEM', ftBCD, 659507017, 2)]
    [Dictionary('TRC_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALDESCTOITEM: Double read FTRC_TOTALDESCTOITEM write FTRC_TOTALDESCTOITEM;
    const TRC_TOTALDESCTOITEM_Name = 'TRC_TOTALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALLIQUIDO', ftBCD, 7077999, 2)]
    [Dictionary('TRC_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALLIQUIDO: Double read FTRC_TOTALLIQUIDO write FTRC_TOTALLIQUIDO;
    const TRC_TOTALLIQUIDO_Name = 'TRC_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALPRODUTOS', ftBCD, 1952531540, 2)]
    [Dictionary('TRC_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALPRODUTOS: Double read FTRC_TOTALPRODUTOS write FTRC_TOTALPRODUTOS;
    const TRC_TOTALPRODUTOS_Name = 'TRC_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('TRC_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('TRC_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALPESOBRUTO: Double read FTRC_TOTALPESOBRUTO write FTRC_TOTALPESOBRUTO;
    const TRC_TOTALPESOBRUTO_Name = 'TRC_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('TRC_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALPESOLIQUIDO: Double read FTRC_TOTALPESOLIQUIDO write FTRC_TOTALPESOLIQUIDO;
    const TRC_TOTALPESOLIQUIDO_Name = 'TRC_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_TOTALQTDTROCADA', ftBCD, 1529377646, 3)]
    [Dictionary('TRC_TOTALQTDTROCADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TRC_TOTALQTDTROCADA: Double read FTRC_TOTALQTDTROCADA write FTRC_TOTALQTDTROCADA;
    const TRC_TOTALQTDTROCADA_Name = 'TRC_TOTALQTDTROCADA';

    [Restrictions([NoValidate])]
    [Column('TRC_OBSERVACAO', ftString, 300)]
    [Dictionary('TRC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_OBSERVACAO: String read FTRC_OBSERVACAO write FTRC_OBSERVACAO;
    const TRC_OBSERVACAO_Name = 'TRC_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_CANCELADA', ftString, 1)]
    [Dictionary('TRC_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_CANCELADA: String read FTRC_CANCELADA write FTRC_CANCELADA;
    const TRC_CANCELADA_Name = 'TRC_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_PROCESSADO', ftString, 1)]
    [Dictionary('TRC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRC_PROCESSADO: String read FTRC_PROCESSADO write FTRC_PROCESSADO;
    const TRC_PROCESSADO_Name = 'TRC_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TRC_DATAALTERACAO', ftDateTime)]
    [Dictionary('TRC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TRC_DATAALTERACAO: TDateTime read FTRC_DATAALTERACAO write FTRC_DATAALTERACAO;
    const TRC_DATAALTERACAO_Name = 'TRC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('TRC_ID_OLD', ftInteger)]
    [Dictionary('TRC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRC_ID_OLD: Integer read FTRC_ID_OLD write FTRC_ID_OLD;
    const TRC_ID_OLD_Name = 'TRC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTRC_00)

end.
