unit express.dbo.VEF_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.vef_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('VEF_00_03', '')]
  [PrimaryKey('VEF_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_VEF_03_ID')]
  TDtoVEF_00_03 = class
  private
    { Private declarations } 
    FVEF_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEF_ID: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FCOR_CODIGO: String;
    FVEF_QTDDESISTENCIA: Double;
    FVEF_DATADESISTENCIA: TDateTime;
    FVEF_MOTIVODESISTENCIA: String;
    FVEF_DATAALTERACAO: TDateTime;
    FVEF_03_ID_OLD: Integer;
    FVEF_ID_OLD: Integer;
  public
    { Public declarations }

    const Table      = 'VEF_00_03';
    const PrimaryKey = 'VEF_03_ID';
    const Sequence   = 'SEQ_VEF_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_03_ID', ftInteger)]
    [Dictionary('VEF_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_03_ID: Integer read FVEF_03_ID write FVEF_03_ID;
    const VEF_03_ID_Name = 'VEF_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [ForeignKey('VEF_00_03_fk', 'VEF_ID', 'VEF_00', 'VEF_ID', SetNull, SetNull)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COR_CODIGO', ftString, 3)]
    [Dictionary('COR_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COR_CODIGO: String read FCOR_CODIGO write FCOR_CODIGO;
    const COR_CODIGO_Name = 'COR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEF_QTDDESISTENCIA', ftBCD, 18, 4)]
    [Dictionary('VEF_QTDDESISTENCIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDDESISTENCIA: Double read FVEF_QTDDESISTENCIA write FVEF_QTDDESISTENCIA;
    const VEF_QTDDESISTENCIA_Name = 'VEF_QTDDESISTENCIA';

    [Restrictions([NoValidate])]
    [Column('VEF_DATADESISTENCIA', ftDateTime)]
    [Dictionary('VEF_DATADESISTENCIA', 'Mensagem de validação', '', '', '', taCenter)]
    property VEF_DATADESISTENCIA: TDateTime read FVEF_DATADESISTENCIA write FVEF_DATADESISTENCIA;
    const VEF_DATADESISTENCIA_Name = 'VEF_DATADESISTENCIA';

    [Restrictions([NoValidate])]
    [Column('VEF_MOTIVODESISTENCIA', ftString, 3000)]
    [Dictionary('VEF_MOTIVODESISTENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_MOTIVODESISTENCIA: String read FVEF_MOTIVODESISTENCIA write FVEF_MOTIVODESISTENCIA;
    const VEF_MOTIVODESISTENCIA_Name = 'VEF_MOTIVODESISTENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('VEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATAALTERACAO: TDateTime read FVEF_DATAALTERACAO write FVEF_DATAALTERACAO;
    const VEF_DATAALTERACAO_Name = 'VEF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('VEF_03_ID_OLD', ftInteger)]
    [Dictionary('VEF_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_03_ID_OLD: Integer read FVEF_03_ID_OLD write FVEF_03_ID_OLD;
    const VEF_03_ID_OLD_Name = 'VEF_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('VEF_ID_OLD', ftInteger)]
    [Dictionary('VEF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID_OLD: Integer read FVEF_ID_OLD write FVEF_ID_OLD;
    const VEF_ID_OLD_Name = 'VEF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEF_00_03)

end.
