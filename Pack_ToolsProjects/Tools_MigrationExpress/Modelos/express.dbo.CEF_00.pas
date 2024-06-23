unit express.dbo.CEF_00;

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
  [Table('CEF_00', '')]
  [PrimaryKey('CEF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CEF_ID')]
  TDtoCEF_00 = class
  private
    { Private declarations } 
    FCEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FCEF_NUMERODOCTO: String;
    FCEF_NUMERODOCTOFAT: String;
    FCEF_DATALANCAMENTO: TDateTime;
    FCEF_OBSERVACAO: String;
    FCEF_TOTALQTDENTREGUE: Double;
    FCEF_CANCELADO: String;
    FCEF_DATACANCELAMENTO: TDateTime;
    FCEF_OBSERVACAOCANCELAMENTO: String;
    FCEF_PROCESSADO: String;
    FCEF_DATAALTERACAO: TDateTime;
    FCEF_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CEF_00';
     const PrimaryKey = 'CEF_ID';
     const Sequence   = 'SEQ_CEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_ID', ftInteger)]
    [Dictionary('CEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_ID: Integer read FCEF_ID write FCEF_ID;
    const CEF_ID_Name = 'CEF_ID';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CEF_NUMERODOCTO', ftString, 15)]
    [Dictionary('CEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_NUMERODOCTO: String read FCEF_NUMERODOCTO write FCEF_NUMERODOCTO;
    const CEF_NUMERODOCTO_Name = 'CEF_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CEF_NUMERODOCTOFAT', ftString, 100)]
    [Dictionary('CEF_NUMERODOCTOFAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_NUMERODOCTOFAT: String read FCEF_NUMERODOCTOFAT write FCEF_NUMERODOCTOFAT;
    const CEF_NUMERODOCTOFAT_Name = 'CEF_NUMERODOCTOFAT';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CEF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CEF_DATALANCAMENTO: TDateTime read FCEF_DATALANCAMENTO write FCEF_DATALANCAMENTO;
    const CEF_DATALANCAMENTO_Name = 'CEF_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CEF_OBSERVACAO', ftString, 300)]
    [Dictionary('CEF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_OBSERVACAO: String read FCEF_OBSERVACAO write FCEF_OBSERVACAO;
    const CEF_OBSERVACAO_Name = 'CEF_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_TOTALQTDENTREGUE', ftBCD, 18, 4)]
    [Dictionary('CEF_TOTALQTDENTREGUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CEF_TOTALQTDENTREGUE: Double read FCEF_TOTALQTDENTREGUE write FCEF_TOTALQTDENTREGUE;
    const CEF_TOTALQTDENTREGUE_Name = 'CEF_TOTALQTDENTREGUE';

    [Restrictions([NoValidate])]
    [Column('CEF_CANCELADO', ftString, 1)]
    [Dictionary('CEF_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_CANCELADO: String read FCEF_CANCELADO write FCEF_CANCELADO;
    const CEF_CANCELADO_Name = 'CEF_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CEF_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('CEF_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CEF_DATACANCELAMENTO: TDateTime read FCEF_DATACANCELAMENTO write FCEF_DATACANCELAMENTO;
    const CEF_DATACANCELAMENTO_Name = 'CEF_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CEF_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('CEF_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_OBSERVACAOCANCELAMENTO: String read FCEF_OBSERVACAOCANCELAMENTO write FCEF_OBSERVACAOCANCELAMENTO;
    const CEF_OBSERVACAOCANCELAMENTO_Name = 'CEF_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CEF_PROCESSADO', ftString, 1)]
    [Dictionary('CEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_PROCESSADO: String read FCEF_PROCESSADO write FCEF_PROCESSADO;
    const CEF_PROCESSADO_Name = 'CEF_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CEF_DATAALTERACAO: TDateTime read FCEF_DATAALTERACAO write FCEF_DATAALTERACAO;
    const CEF_DATAALTERACAO_Name = 'CEF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CEF_ID_OLD', ftInteger)]
    [Dictionary('CEF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_ID_OLD: Integer read FCEF_ID_OLD write FCEF_ID_OLD;
    const CEF_ID_OLD_Name = 'CEF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCEF_00)

end.
