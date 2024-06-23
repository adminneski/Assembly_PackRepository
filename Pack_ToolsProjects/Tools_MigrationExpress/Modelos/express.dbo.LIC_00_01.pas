unit express.dbo.LIC_00_01;

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
  [Table('LIC_00_01', '')]
  [PrimaryKey('LIC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LIC_01_ID')]
  TDtoLIC_00_01 = class
  private
    { Private declarations } 
    FLIC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FLIC_ID: Integer;
    FMDO_CODIGO: Integer;
    FLIC_DATAALTERACAO: TDateTime;
    FLIC_01_ID_OLD: Integer;
    FLIC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'LIC_00_01';
     const PrimaryKey = 'LIC_01_ID';
     const Sequence   = 'SEQ_LIC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_01_ID', ftInteger)]
    [Dictionary('LIC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_01_ID: Integer read FLIC_01_ID write FLIC_01_ID;
    const LIC_01_ID_Name = 'LIC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_ID', ftInteger)]
    [Dictionary('LIC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_ID: Integer read FLIC_ID write FLIC_ID;
    const LIC_ID_Name = 'LIC_ID';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_DATAALTERACAO', ftDateTime)]
    [Dictionary('LIC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LIC_DATAALTERACAO: TDateTime read FLIC_DATAALTERACAO write FLIC_DATAALTERACAO;
    const LIC_DATAALTERACAO_Name = 'LIC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LIC_01_ID_OLD', ftInteger)]
    [Dictionary('LIC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_01_ID_OLD: Integer read FLIC_01_ID_OLD write FLIC_01_ID_OLD;
    const LIC_01_ID_OLD_Name = 'LIC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LIC_ID_OLD', ftInteger)]
    [Dictionary('LIC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_ID_OLD: Integer read FLIC_ID_OLD write FLIC_ID_OLD;
    const LIC_ID_OLD_Name = 'LIC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLIC_00_01)

end.
