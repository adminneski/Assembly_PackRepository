unit express.dbo.PRZ_00_02;

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
  [Table('PRZ_00_02', '')]
  [PrimaryKey('PRZ_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRZ_02_ID')]
  TDtoPRZ_00_02 = class
  private
    { Private declarations } 
    FPRZ_02_ID: Integer;
    FPRZ_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPRZ_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRZ_00_02';
     const PrimaryKey = 'PRZ_02_ID';
     const Sequence   = 'SEQ_PRZ_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_02_ID', ftInteger)]
    [Dictionary('PRZ_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_02_ID: Integer read FPRZ_02_ID write FPRZ_02_ID;
    const PRZ_02_ID_Name = 'PRZ_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

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
  TRegisterClass.RegisterEntity(TDtoPRZ_00_02)

end.
