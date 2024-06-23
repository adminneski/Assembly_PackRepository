unit express.dbo.PRO_00_02;

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
  [Table('PRO_00_02', '')]
  [PrimaryKey('PRO_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_02_ID')]
  TDtoPRO_00_02 = class
  private
    { Private declarations } 
    FPRO_02_ID: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FPRO_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_02';
     const PrimaryKey = 'PRO_02_ID';
     const Sequence   = 'SEQ_PRO_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_02_ID', ftInteger)]
    [Dictionary('PRO_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_02_ID: Integer read FPRO_02_ID write FPRO_02_ID;
    const PRO_02_ID_Name = 'PRO_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRD_CODIGO', ftString, 10)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00_02)

end.
