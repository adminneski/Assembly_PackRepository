unit express.dbo.INV_00_01;

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
  [Table('INV_00_01', '')]
  [PrimaryKey('INV_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_INV_01_ID')]
  TDtoINV_00_01 = class
  private
    { Private declarations } 
    FINV_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FINV_DATAFECHAMENTO: TDateTime;
    FINV_MODELOFECHAMENTO: String;
    FINV_DATAALTERACAO: TDateTime;
    FINV_01_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'INV_00_01';
     const PrimaryKey = 'INV_01_ID';
     const Sequence   = 'SEQ_INV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_01_ID', ftInteger)]
    [Dictionary('INV_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_01_ID: Integer read FINV_01_ID write FINV_01_ID;
    const INV_01_ID_Name = 'INV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('INV_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INV_DATAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATAFECHAMENTO: TDateTime read FINV_DATAFECHAMENTO write FINV_DATAFECHAMENTO;
    const INV_DATAFECHAMENTO_Name = 'INV_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('INV_MODELOFECHAMENTO', ftString, 3)]
    [Dictionary('INV_MODELOFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_MODELOFECHAMENTO: String read FINV_MODELOFECHAMENTO write FINV_MODELOFECHAMENTO;
    const INV_MODELOFECHAMENTO_Name = 'INV_MODELOFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('INV_DATAALTERACAO', ftDateTime)]
    [Dictionary('INV_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATAALTERACAO: TDateTime read FINV_DATAALTERACAO write FINV_DATAALTERACAO;
    const INV_DATAALTERACAO_Name = 'INV_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('INV_01_ID_OLD', ftInteger)]
    [Dictionary('INV_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_01_ID_OLD: Integer read FINV_01_ID_OLD write FINV_01_ID_OLD;
    const INV_01_ID_OLD_Name = 'INV_01_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoINV_00_01)

end.
