unit express.dbo.CRF_00;

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
  [Table('CRF_00', '')]
  [PrimaryKey('CRF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRF_ID')]
  TDtoCRF_00 = class
  private
    { Private declarations } 
    FCRF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCRF_NUMERODOCTO: String;
    FCRF_DATALANCAMENTO: TDateTime;
    FCRF_OBSERVACAO: String;
    FCRF_CANCELADO: String;
    FCRF_DATACANCELAMENTO: TDateTime;
    FCRF_OBSERVACAOCANCELAMENTO: String;
    FCRF_TOTALQTDRECOLHIDA: Double;
    FCRF_DATAALTERACAO: TDateTime;
    FCRF_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CRF_00';
     const PrimaryKey = 'CRF_ID';
     const Sequence   = 'SEQ_CRF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_ID', ftInteger)]
    [Dictionary('CRF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_ID: Integer read FCRF_ID write FCRF_ID;
    const CRF_ID_Name = 'CRF_ID';

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

    [Restrictions([NoValidate])]
    [Column('CRF_NUMERODOCTO', ftString, 10)]
    [Dictionary('CRF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRF_NUMERODOCTO: String read FCRF_NUMERODOCTO write FCRF_NUMERODOCTO;
    const CRF_NUMERODOCTO_Name = 'CRF_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CRF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRF_DATALANCAMENTO: TDateTime read FCRF_DATALANCAMENTO write FCRF_DATALANCAMENTO;
    const CRF_DATALANCAMENTO_Name = 'CRF_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CRF_OBSERVACAO', ftString, 300)]
    [Dictionary('CRF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRF_OBSERVACAO: String read FCRF_OBSERVACAO write FCRF_OBSERVACAO;
    const CRF_OBSERVACAO_Name = 'CRF_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_CANCELADO', ftString, 1)]
    [Dictionary('CRF_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRF_CANCELADO: String read FCRF_CANCELADO write FCRF_CANCELADO;
    const CRF_CANCELADO_Name = 'CRF_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CRF_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('CRF_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRF_DATACANCELAMENTO: TDateTime read FCRF_DATACANCELAMENTO write FCRF_DATACANCELAMENTO;
    const CRF_DATACANCELAMENTO_Name = 'CRF_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CRF_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('CRF_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRF_OBSERVACAOCANCELAMENTO: String read FCRF_OBSERVACAOCANCELAMENTO write FCRF_OBSERVACAOCANCELAMENTO;
    const CRF_OBSERVACAOCANCELAMENTO_Name = 'CRF_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_TOTALQTDRECOLHIDA', ftBCD)]
    [Dictionary('CRF_TOTALQTDRECOLHIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRF_TOTALQTDRECOLHIDA: Double read FCRF_TOTALQTDRECOLHIDA write FCRF_TOTALQTDRECOLHIDA;
    const CRF_TOTALQTDRECOLHIDA_Name = 'CRF_TOTALQTDRECOLHIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRF_DATAALTERACAO: TDateTime read FCRF_DATAALTERACAO write FCRF_DATAALTERACAO;
    const CRF_DATAALTERACAO_Name = 'CRF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRF_ID_OLD', ftInteger)]
    [Dictionary('CRF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_ID_OLD: Integer read FCRF_ID_OLD write FCRF_ID_OLD;
    const CRF_ID_OLD_Name = 'CRF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRF_00)

end.
