unit express.dbo.ORS_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ors_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ORS_00_03', '')]
  [PrimaryKey('ORS_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_03_ID')]
  TDtoORS_00_03 = class
  private
    { Private declarations } 
    FORS_03_ID: Integer;
    FORS_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_ID_MSC: Integer;
    FORS_DATAALTERACAO: TDateTime;
    FORS_03_ID_OLD: Integer;
    FORS_ID_OLD: Integer;
    FORS_ID_MSC_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'ORS_00_03';
    const PrimaryKey = 'ORS_03_ID';
    const Sequence   = 'SEQ_ORS_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_03_ID', ftInteger)]
    [Dictionary('ORS_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_03_ID: Integer read FORS_03_ID write FORS_03_ID;
    const ORS_03_ID_Name = 'ORS_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_00_03_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID_MSC', ftInteger)]
    [Dictionary('ORS_ID_MSC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_MSC: Integer read FORS_ID_MSC write FORS_ID_MSC;
    const ORS_ID_MSC_Name = 'ORS_ID_MSC';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_03_ID_OLD', ftInteger)]
    [Dictionary('ORS_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_03_ID_OLD: Integer read FORS_03_ID_OLD write FORS_03_ID_OLD;
    const ORS_03_ID_OLD_Name = 'ORS_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_MSC_OLD', ftInteger)]
    [Dictionary('ORS_ID_MSC_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_MSC_OLD: Integer read FORS_ID_MSC_OLD write FORS_ID_MSC_OLD;
    const ORS_ID_MSC_OLD_Name = 'ORS_ID_MSC_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_00_03)

end.
