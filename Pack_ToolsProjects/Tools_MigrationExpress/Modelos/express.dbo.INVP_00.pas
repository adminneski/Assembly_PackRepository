unit express.dbo.INVP_00;

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
  [Table('INVP_00', '')]
  [PrimaryKey('INVP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_INVP_ID')]
  TDtoINVP_00 = class
  private
    { Private declarations } 
    FINVP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FINVP_DATAFECHAMENTO: TDateTime;
    FINVP_DATADIAFECHAMENTO: TDateTime;
    FINVP_SALDOFECHAMENTO: Double;
    FINVP_VALORCUSTOARMAZENAGEM: Double;
    FINVP_VALORCUSTOARMAZENAGEMMEDIO: Double;
    FINVP_QTDENTRADA: Double;
    FINVP_QTDSAIDA: Double;
    FINVP_DESATIVADO: String;
    FINVP_DATAALTERACAO: TDateTime;
    FINVP_TIPOPOSSE: String;
    FINVP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'INVP_00';
     const PrimaryKey = 'INVP_ID';
     const Sequence   = 'SEQ_INVP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ID', ftInteger)]
    [Dictionary('INVP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ID: Integer read FINVP_ID write FINVP_ID;
    const INVP_ID_Name = 'INVP_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INVP_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property INVP_DATAFECHAMENTO: TDateTime read FINVP_DATAFECHAMENTO write FINVP_DATAFECHAMENTO;
    const INVP_DATAFECHAMENTO_Name = 'INVP_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('INVP_DATADIAFECHAMENTO', ftDateTime)]
    [Dictionary('INVP_DATADIAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property INVP_DATADIAFECHAMENTO: TDateTime read FINVP_DATADIAFECHAMENTO write FINVP_DATADIAFECHAMENTO;
    const INVP_DATADIAFECHAMENTO_Name = 'INVP_DATADIAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('INVP_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_SALDOFECHAMENTO: Double read FINVP_SALDOFECHAMENTO write FINVP_SALDOFECHAMENTO;
    const INVP_SALDOFECHAMENTO_Name = 'INVP_SALDOFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEM', ftBCD, 18, 4)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEM: Double read FINVP_VALORCUSTOARMAZENAGEM write FINVP_VALORCUSTOARMAZENAGEM;
    const INVP_VALORCUSTOARMAZENAGEM_Name = 'INVP_VALORCUSTOARMAZENAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEMMEDIO', ftBCD, 18, 4)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEMMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEMMEDIO: Double read FINVP_VALORCUSTOARMAZENAGEMMEDIO write FINVP_VALORCUSTOARMAZENAGEMMEDIO;
    const INVP_VALORCUSTOARMAZENAGEMMEDIO_Name = 'INVP_VALORCUSTOARMAZENAGEMMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('INVP_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_QTDENTRADA: Double read FINVP_QTDENTRADA write FINVP_QTDENTRADA;
    const INVP_QTDENTRADA_Name = 'INVP_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('INVP_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_QTDSAIDA: Double read FINVP_QTDSAIDA write FINVP_QTDSAIDA;
    const INVP_QTDSAIDA_Name = 'INVP_QTDSAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_DESATIVADO', ftString, 1)]
    [Dictionary('INVP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_DESATIVADO: String read FINVP_DESATIVADO write FINVP_DESATIVADO;
    const INVP_DESATIVADO_Name = 'INVP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('INVP_DATAALTERACAO', ftDateTime)]
    [Dictionary('INVP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property INVP_DATAALTERACAO: TDateTime read FINVP_DATAALTERACAO write FINVP_DATAALTERACAO;
    const INVP_DATAALTERACAO_Name = 'INVP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('INVP_TIPOPOSSE', ftString, 1)]
    [Dictionary('INVP_TIPOPOSSE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_TIPOPOSSE: String read FINVP_TIPOPOSSE write FINVP_TIPOPOSSE;
    const INVP_TIPOPOSSE_Name = 'INVP_TIPOPOSSE';

    [Restrictions([NoValidate])]
    [Column('INVP_ID_OLD', ftInteger)]
    [Dictionary('INVP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ID_OLD: Integer read FINVP_ID_OLD write FINVP_ID_OLD;
    const INVP_ID_OLD_Name = 'INVP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoINVP_00)

end.
