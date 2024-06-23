unit express.dbo.AGN_00;

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
  [Table('AGN_00', '')]
  [PrimaryKey('AGN_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AGN_ID')]
  TDtoAGN_00 = class
  private
    { Private declarations } 
    FAGN_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FAGN_NOMECLIENTE: String;
    FAGN_TELEFONECLIENTE: String;
    FAGN_SOLICITACAOCLIENTE: String;
    FAGN_DATAAGENDAMENTO: TDateTime;
    FAGN_HORAAGENDAMENTO: String;
    FAGN_CANCELADO: String;
    FAGN_DATAALTERACAO: TDateTime;
    FAGN_STATUS: String;
    FAGN_NUMEROOS: Integer;
    FAGN_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'AGN_00';
     const PrimaryKey = 'AGN_ID';
     const Sequence   = 'SEQ_AGN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('AGN_ID', ftInteger)]
    [Dictionary('AGN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property AGN_ID: Integer read FAGN_ID write FAGN_ID;
    const AGN_ID_Name = 'AGN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AGN_NOMECLIENTE', ftString, 100)]
    [Dictionary('AGN_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_NOMECLIENTE: String read FAGN_NOMECLIENTE write FAGN_NOMECLIENTE;
    const AGN_NOMECLIENTE_Name = 'AGN_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('AGN_TELEFONECLIENTE', ftString, 11)]
    [Dictionary('AGN_TELEFONECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_TELEFONECLIENTE: String read FAGN_TELEFONECLIENTE write FAGN_TELEFONECLIENTE;
    const AGN_TELEFONECLIENTE_Name = 'AGN_TELEFONECLIENTE';

    [Restrictions([NoValidate])]
    [Column('AGN_SOLICITACAOCLIENTE', ftString, 5000)]
    [Dictionary('AGN_SOLICITACAOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_SOLICITACAOCLIENTE: String read FAGN_SOLICITACAOCLIENTE write FAGN_SOLICITACAOCLIENTE;
    const AGN_SOLICITACAOCLIENTE_Name = 'AGN_SOLICITACAOCLIENTE';

    [Restrictions([NoValidate])]
    [Column('AGN_DATAAGENDAMENTO', ftDateTime)]
    [Dictionary('AGN_DATAAGENDAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property AGN_DATAAGENDAMENTO: TDateTime read FAGN_DATAAGENDAMENTO write FAGN_DATAAGENDAMENTO;
    const AGN_DATAAGENDAMENTO_Name = 'AGN_DATAAGENDAMENTO';

    [Restrictions([NoValidate])]
    [Column('AGN_HORAAGENDAMENTO', ftString, 8)]
    [Dictionary('AGN_HORAAGENDAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_HORAAGENDAMENTO: String read FAGN_HORAAGENDAMENTO write FAGN_HORAAGENDAMENTO;
    const AGN_HORAAGENDAMENTO_Name = 'AGN_HORAAGENDAMENTO';

    [Restrictions([NoValidate])]
    [Column('AGN_CANCELADO', ftString, 1)]
    [Dictionary('AGN_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_CANCELADO: String read FAGN_CANCELADO write FAGN_CANCELADO;
    const AGN_CANCELADO_Name = 'AGN_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('AGN_DATAALTERACAO', ftDateTime)]
    [Dictionary('AGN_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AGN_DATAALTERACAO: TDateTime read FAGN_DATAALTERACAO write FAGN_DATAALTERACAO;
    const AGN_DATAALTERACAO_Name = 'AGN_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('AGN_STATUS', ftString, 1)]
    [Dictionary('AGN_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_STATUS: String read FAGN_STATUS write FAGN_STATUS;
    const AGN_STATUS_Name = 'AGN_STATUS';

    [Restrictions([NoValidate])]
    [Column('AGN_NUMEROOS', ftInteger)]
    [Dictionary('AGN_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property AGN_NUMEROOS: Integer read FAGN_NUMEROOS write FAGN_NUMEROOS;
    const AGN_NUMEROOS_Name = 'AGN_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('AGN_ID_OLD', ftInteger)]
    [Dictionary('AGN_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property AGN_ID_OLD: Integer read FAGN_ID_OLD write FAGN_ID_OLD;
    const AGN_ID_OLD_Name = 'AGN_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAGN_00)

end.
