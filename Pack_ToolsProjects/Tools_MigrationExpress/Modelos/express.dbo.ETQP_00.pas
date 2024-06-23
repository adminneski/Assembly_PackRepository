unit express.dbo.ETQP_00;

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
  [Table('ETQP_00', '')]
  [PrimaryKey('ETQP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ETQP_ID')]
  TDtoETQP_00 = class
  private
    { Private declarations } 
    FETQP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FETQP_ESTOQUEFILIAL: Double;
    FETQP_VALORCUSTOARMAZENAGEM: Double;
    FETQP_VALORCUSTOARMAZENAGEMMEDIO: Double;
    FETQP_DATAALTERACAO: TDateTime;
    FETQP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'ETQP_00';
     const PrimaryKey = 'ETQP_ID';
     const Sequence   = 'SEQ_ETQP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQP_ID', ftInteger)]
    [Dictionary('ETQP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQP_ID: Integer read FETQP_ID write FETQP_ID;
    const ETQP_ID_Name = 'ETQP_ID';

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
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQP_ESTOQUEFILIAL', ftBCD)]
    [Dictionary('ETQP_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQP_ESTOQUEFILIAL: Double read FETQP_ESTOQUEFILIAL write FETQP_ESTOQUEFILIAL;
    const ETQP_ESTOQUEFILIAL_Name = 'ETQP_ESTOQUEFILIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQP_VALORCUSTOARMAZENAGEM', ftBCD, 18, 4)]
    [Dictionary('ETQP_VALORCUSTOARMAZENAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQP_VALORCUSTOARMAZENAGEM: Double read FETQP_VALORCUSTOARMAZENAGEM write FETQP_VALORCUSTOARMAZENAGEM;
    const ETQP_VALORCUSTOARMAZENAGEM_Name = 'ETQP_VALORCUSTOARMAZENAGEM';

    [Restrictions([NoValidate])]
    [Column('ETQP_VALORCUSTOARMAZENAGEMMEDIO', ftBCD, 18, 4)]
    [Dictionary('ETQP_VALORCUSTOARMAZENAGEMMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQP_VALORCUSTOARMAZENAGEMMEDIO: Double read FETQP_VALORCUSTOARMAZENAGEMMEDIO write FETQP_VALORCUSTOARMAZENAGEMMEDIO;
    const ETQP_VALORCUSTOARMAZENAGEMMEDIO_Name = 'ETQP_VALORCUSTOARMAZENAGEMMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQP_DATAALTERACAO', ftDateTime)]
    [Dictionary('ETQP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETQP_DATAALTERACAO: TDateTime read FETQP_DATAALTERACAO write FETQP_DATAALTERACAO;
    const ETQP_DATAALTERACAO_Name = 'ETQP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ETQP_ID_OLD', ftInteger)]
    [Dictionary('ETQP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQP_ID_OLD: Integer read FETQP_ID_OLD write FETQP_ID_OLD;
    const ETQP_ID_OLD_Name = 'ETQP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoETQP_00)

end.
