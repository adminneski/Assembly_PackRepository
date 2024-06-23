unit express.dbo.DCH_00;

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
  [Table('DCH_00', '')]
  [PrimaryKey('DCH_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DCH_ID')]
  TDtoDCH_00 = class
  private
    { Private declarations } 
    FDCH_ID: Integer;
    FCOM_CODIGO: Integer;
    FDCH_HISTORICO: String;
    FDCH_PROCESSADO: String;
    FDCH_TOTALCHEQUES: Double;
    FDCH_DATALANCAMENTO: TDateTime;
    FDCH_DATAALTERACAO: TDateTime;
    FDCH_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'DCH_00';
     const PrimaryKey = 'DCH_ID';
     const Sequence   = 'SEQ_DCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_ID', ftInteger)]
    [Dictionary('DCH_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DCH_ID: Integer read FDCH_ID write FDCH_ID;
    const DCH_ID_Name = 'DCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DCH_HISTORICO', ftString, 300)]
    [Dictionary('DCH_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DCH_HISTORICO: String read FDCH_HISTORICO write FDCH_HISTORICO;
    const DCH_HISTORICO_Name = 'DCH_HISTORICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_PROCESSADO', ftString, 1)]
    [Dictionary('DCH_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DCH_PROCESSADO: String read FDCH_PROCESSADO write FDCH_PROCESSADO;
    const DCH_PROCESSADO_Name = 'DCH_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_TOTALCHEQUES', ftBCD)]
    [Dictionary('DCH_TOTALCHEQUES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DCH_TOTALCHEQUES: Double read FDCH_TOTALCHEQUES write FDCH_TOTALCHEQUES;
    const DCH_TOTALCHEQUES_Name = 'DCH_TOTALCHEQUES';

    [Restrictions([NoValidate, NotNull])]
    [Column('DCH_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DCH_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DCH_DATALANCAMENTO: TDateTime read FDCH_DATALANCAMENTO write FDCH_DATALANCAMENTO;
    const DCH_DATALANCAMENTO_Name = 'DCH_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('DCH_DATAALTERACAO', ftDateTime)]
    [Dictionary('DCH_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property DCH_DATAALTERACAO: TDateTime read FDCH_DATAALTERACAO write FDCH_DATAALTERACAO;
    const DCH_DATAALTERACAO_Name = 'DCH_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DCH_ID_OLD', ftInteger)]
    [Dictionary('DCH_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DCH_ID_OLD: Integer read FDCH_ID_OLD write FDCH_ID_OLD;
    const DCH_ID_OLD_Name = 'DCH_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDCH_00)

end.
