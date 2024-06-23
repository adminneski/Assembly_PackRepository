unit express.dbo.ORS_00_02_01;

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
  [Table('ORS_00_02_01', '')]
  [PrimaryKey('ORS_02_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_02_01_ID')]
  TDtoORS_00_02_01 = class
  private
    { Private declarations } 
    FORS_02_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_ID: Integer;
    FORS_02_ID: Integer;
    FMDO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FORS_PERCENTUALRATEIO: Double;
    FORS_DATAALTERACAO: TDateTime;
    FORS_02_01_ID_OLD: Integer;
    FORS_02_ID_OLD: Integer;
    FORS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'ORS_00_02_01';
    const PrimaryKey = 'ORS_02_01_ID';
    const Sequence   = 'SEQ_ORS_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_02_01_ID', ftInteger)]
    [Dictionary('ORS_02_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_02_01_ID: Integer read FORS_02_01_ID write FORS_02_01_ID;
    const ORS_02_01_ID_Name = 'ORS_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_00_02_01_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_02_ID', ftInteger)]
    [Dictionary('ORS_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_02_ID: Integer read FORS_02_ID write FORS_02_ID;
    const ORS_02_ID_Name = 'ORS_02_ID';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALRATEIO', ftBCD, 2097184, 2)]
    [Dictionary('ORS_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALRATEIO: Double read FORS_PERCENTUALRATEIO write FORS_PERCENTUALRATEIO;
    const ORS_PERCENTUALRATEIO_Name = 'ORS_PERCENTUALRATEIO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_02_01_ID_OLD', ftInteger)]
    [Dictionary('ORS_02_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_02_01_ID_OLD: Integer read FORS_02_01_ID_OLD write FORS_02_01_ID_OLD;
    const ORS_02_01_ID_OLD_Name = 'ORS_02_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_02_ID_OLD', ftInteger)]
    [Dictionary('ORS_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_02_ID_OLD: Integer read FORS_02_ID_OLD write FORS_02_ID_OLD;
    const ORS_02_ID_OLD_Name = 'ORS_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoORS_00_02_01)

end.
