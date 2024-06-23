unit express.dbo.LEE_00_01;

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
  [Table('LEE_00_01', '')]
  [PrimaryKey('LEE_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LEE_01_ID')]
  TDtoLEE_00_01 = class
  private
    { Private declarations } 
    FLEE_01_ID: Integer;
    FLEE_CODIGO: Integer;
    FNCM_CODIGO: Integer;
    FLEE_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'LEE_00_01';
     const PrimaryKey = 'LEE_01_ID';
     const Sequence   = 'SEQ_LEE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_01_ID', ftInteger)]
    [Dictionary('LEE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_01_ID: Integer read FLEE_01_ID write FLEE_01_ID;
    const LEE_01_ID_Name = 'LEE_01_ID';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LEE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LEE_DATAALTERACAO: TDateTime read FLEE_DATAALTERACAO write FLEE_DATAALTERACAO;
    const LEE_DATAALTERACAO_Name = 'LEE_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLEE_00_01)

end.
