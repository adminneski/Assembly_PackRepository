unit express.dbo.PRZ_00_01;

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
  [Table('PRZ_00_01', '')]
  [PrimaryKey('PRZ_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRZ_01_ID')]
  TDtoPRZ_00_01 = class
  private
    { Private declarations } 
    FPRZ_01_ID: Integer;
    FPRZ_CODIGO: Integer;
    FPRZ_DIAS: Integer;
    FPRZ_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRZ_00_01';
     const PrimaryKey = 'PRZ_01_ID';
     const Sequence   = 'SEQ_PRZ_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_01_ID', ftInteger)]
    [Dictionary('PRZ_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_01_ID: Integer read FPRZ_01_ID write FPRZ_01_ID;
    const PRZ_01_ID_Name = 'PRZ_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_DIAS', ftInteger)]
    [Dictionary('PRZ_DIAS', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_DIAS: Integer read FPRZ_DIAS write FPRZ_DIAS;
    const PRZ_DIAS_Name = 'PRZ_DIAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRZ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRZ_DATAALTERACAO: TDateTime read FPRZ_DATAALTERACAO write FPRZ_DATAALTERACAO;
    const PRZ_DATAALTERACAO_Name = 'PRZ_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRZ_00_01)

end.
