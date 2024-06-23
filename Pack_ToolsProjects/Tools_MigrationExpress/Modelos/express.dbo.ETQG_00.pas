unit express.dbo.ETQG_00;

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
  [Table('ETQG_00', '')]
  [PrimaryKey('ETQG_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ETQG_ID')]
  TDtoETQG_00 = class
  private
    { Private declarations } 
    FETQG_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FETQG_ESTOQUEFILIAL: Double;
    FETQG_DATAALTERACAO: TDateTime;
    FETQG_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'ETQG_00';
     const PrimaryKey = 'ETQG_ID';
     const Sequence   = 'SEQ_ETQG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQG_ID', ftInteger)]
    [Dictionary('ETQG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQG_ID: Integer read FETQG_ID write FETQG_ID;
    const ETQG_ID_Name = 'ETQG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_CODIGO', ftString, 3)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQG_ESTOQUEFILIAL', ftBCD)]
    [Dictionary('ETQG_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQG_ESTOQUEFILIAL: Double read FETQG_ESTOQUEFILIAL write FETQG_ESTOQUEFILIAL;
    const ETQG_ESTOQUEFILIAL_Name = 'ETQG_ESTOQUEFILIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ETQG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETQG_DATAALTERACAO: TDateTime read FETQG_DATAALTERACAO write FETQG_DATAALTERACAO;
    const ETQG_DATAALTERACAO_Name = 'ETQG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ETQG_ID_OLD', ftInteger)]
    [Dictionary('ETQG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQG_ID_OLD: Integer read FETQG_ID_OLD write FETQG_ID_OLD;
    const ETQG_ID_OLD_Name = 'ETQG_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoETQG_00)

end.
