unit express.dbo.CMD_00;

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
  [Table('CMD_00', '')]
  [PrimaryKey('CMD_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CMD_ID')]
  TDtoCMD_00 = class
  private
    { Private declarations } 
    FCMD_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCMD_NUMERODOCTO: String;
    FCMD_DATALANCAMENTO: TDateTime;
    FCMD_OBSERVACAO: String;
    FCMD_CANCELADO: String;
    FCMD_DATACANCELAMENTO: TDateTime;
    FCMD_OBSERVACAOCANCELAMENTO: String;
    FCMD_TOTALQTDCOMODATO: Double;
    FCMD_DATAALTERACAO: TDateTime;
    FCMD_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CMD_00';
     const PrimaryKey = 'CMD_ID';
     const Sequence   = 'SEQ_CMD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_ID', ftInteger)]
    [Dictionary('CMD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_ID: Integer read FCMD_ID write FCMD_ID;
    const CMD_ID_Name = 'CMD_ID';

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
    [Column('CMD_NUMERODOCTO', ftString, 10)]
    [Dictionary('CMD_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMD_NUMERODOCTO: String read FCMD_NUMERODOCTO write FCMD_NUMERODOCTO;
    const CMD_NUMERODOCTO_Name = 'CMD_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CMD_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMD_DATALANCAMENTO: TDateTime read FCMD_DATALANCAMENTO write FCMD_DATALANCAMENTO;
    const CMD_DATALANCAMENTO_Name = 'CMD_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CMD_OBSERVACAO', ftString, 300)]
    [Dictionary('CMD_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMD_OBSERVACAO: String read FCMD_OBSERVACAO write FCMD_OBSERVACAO;
    const CMD_OBSERVACAO_Name = 'CMD_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_CANCELADO', ftString, 1)]
    [Dictionary('CMD_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMD_CANCELADO: String read FCMD_CANCELADO write FCMD_CANCELADO;
    const CMD_CANCELADO_Name = 'CMD_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CMD_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('CMD_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CMD_DATACANCELAMENTO: TDateTime read FCMD_DATACANCELAMENTO write FCMD_DATACANCELAMENTO;
    const CMD_DATACANCELAMENTO_Name = 'CMD_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CMD_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('CMD_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMD_OBSERVACAOCANCELAMENTO: String read FCMD_OBSERVACAOCANCELAMENTO write FCMD_OBSERVACAOCANCELAMENTO;
    const CMD_OBSERVACAOCANCELAMENTO_Name = 'CMD_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_TOTALQTDCOMODATO', ftBCD)]
    [Dictionary('CMD_TOTALQTDCOMODATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMD_TOTALQTDCOMODATO: Double read FCMD_TOTALQTDCOMODATO write FCMD_TOTALQTDCOMODATO;
    const CMD_TOTALQTDCOMODATO_Name = 'CMD_TOTALQTDCOMODATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_DATAALTERACAO', ftDateTime)]
    [Dictionary('CMD_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMD_DATAALTERACAO: TDateTime read FCMD_DATAALTERACAO write FCMD_DATAALTERACAO;
    const CMD_DATAALTERACAO_Name = 'CMD_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CMD_ID_OLD', ftInteger)]
    [Dictionary('CMD_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_ID_OLD: Integer read FCMD_ID_OLD write FCMD_ID_OLD;
    const CMD_ID_OLD_Name = 'CMD_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCMD_00)

end.
