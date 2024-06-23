unit express.dbo.ATB_00_01;

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
  [Table('ATB_00_01', '')]
  [PrimaryKey('ATB_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ATB_01_ID')]
  TDtoATB_00_01 = class
  private
    { Private declarations } 
    FATB_01_ID: Integer;
    FATB_CODIGO: Integer;
    FNCM_CODIGO: Integer;
    FATB_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'ATB_00_01';
     const PrimaryKey = 'ATB_01_ID';
     const Sequence   = 'SEQ_ATB_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ATB_01_ID', ftInteger)]
    [Dictionary('ATB_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ATB_01_ID: Integer read FATB_01_ID write FATB_01_ID;
    const ATB_01_ID_Name = 'ATB_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ATB_CODIGO', ftInteger)]
    [Dictionary('ATB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ATB_CODIGO: Integer read FATB_CODIGO write FATB_CODIGO;
    const ATB_CODIGO_Name = 'ATB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ATB_DATAALTERACAO', ftDateTime)]
    [Dictionary('ATB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ATB_DATAALTERACAO: TDateTime read FATB_DATAALTERACAO write FATB_DATAALTERACAO;
    const ATB_DATAALTERACAO_Name = 'ATB_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoATB_00_01)

end.
