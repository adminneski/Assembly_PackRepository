unit express.dbo.TAB_00_01;

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
  [Table('TAB_00_01', '')]
  [PrimaryKey('TAB_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TAB_01_ID')]
  TDtoTAB_00_01 = class
  private
    { Private declarations } 
    FTAB_01_ID: Integer;
    FTAB_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FTAB_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'TAB_00_01';
     const PrimaryKey = 'TAB_01_ID';
     const Sequence   = 'SEQ_TAB_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_01_ID', ftInteger)]
    [Dictionary('TAB_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_01_ID: Integer read FTAB_01_ID write FTAB_01_ID;
    const TAB_01_ID_Name = 'TAB_01_ID';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_DATAALTERACAO', ftDateTime)]
    [Dictionary('TAB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TAB_DATAALTERACAO: TDateTime read FTAB_DATAALTERACAO write FTAB_DATAALTERACAO;
    const TAB_DATAALTERACAO_Name = 'TAB_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTAB_00_01)

end.
