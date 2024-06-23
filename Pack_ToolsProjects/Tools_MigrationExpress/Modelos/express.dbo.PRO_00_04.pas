unit express.dbo.PRO_00_04;

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
  [Table('PRO_00_04', '')]
  [PrimaryKey('PRO_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_04_ID')]
  TDtoPRO_00_04 = class
  private
    { Private declarations } 
    FPRO_04_ID: Integer;
    FPRO_CODIGO: Integer;
    FPRO_CODIGOSIMILAR: String;
    FPRO_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_04';
     const PrimaryKey = 'PRO_04_ID';
     const Sequence   = 'SEQ_PRO_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_04_ID', ftInteger)]
    [Dictionary('PRO_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_04_ID: Integer read FPRO_04_ID write FPRO_04_ID;
    const PRO_04_ID_Name = 'PRO_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGOSIMILAR', ftString, 20)]
    [Dictionary('PRO_CODIGOSIMILAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOSIMILAR: String read FPRO_CODIGOSIMILAR write FPRO_CODIGOSIMILAR;
    const PRO_CODIGOSIMILAR_Name = 'PRO_CODIGOSIMILAR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
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
  TRegisterClass.RegisterEntity(TDtoPRO_00_04)

end.
