unit express.dbo.CMD_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cmd_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CMD_00_01', '')]
  [PrimaryKey('CMD_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CMD_01_ID')]
  TDtoCMD_00_01 = class
  private
    { Private declarations } 
    FCMD_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCMD_ID: Integer;
    FONS_ID: Integer;
    FONS_01_ID: Integer;
    FPRO_CODIGO: Integer;
    FCMD_QTDCOMODATO: Double;
    FCMD_QTDFATURADA: Double;
    FCMD_DATAALTERACAO: TDateTime;
    FCMD_01_ID_OLD: Integer;
    FCMD_ID_OLD: Integer;
    FONS_ID_OLD: Integer;
    FONS_01_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CMD_00_01';
    const PrimaryKey = 'CMD_01_ID';
    const Sequence   = 'SEQ_CMD_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_01_ID', ftInteger)]
    [Dictionary('CMD_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_01_ID: Integer read FCMD_01_ID write FCMD_01_ID;
    const CMD_01_ID_Name = 'CMD_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_ID', ftInteger)]
    [ForeignKey('CMD_00_01_fk', 'CMD_ID', 'CMD_00', 'CMD_ID', SetNull, SetNull)]
    [Dictionary('CMD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_ID: Integer read FCMD_ID write FCMD_ID;
    const CMD_ID_Name = 'CMD_ID';

    [Restrictions([NoValidate])]
    [Column('ONS_ID', ftInteger)]
    [Dictionary('ONS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ONS_ID: Integer read FONS_ID write FONS_ID;
    const ONS_ID_Name = 'ONS_ID';

    [Restrictions([NoValidate])]
    [Column('ONS_01_ID', ftInteger)]
    [Dictionary('ONS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ONS_01_ID: Integer read FONS_01_ID write FONS_01_ID;
    const ONS_01_ID_Name = 'ONS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_QTDCOMODATO', ftBCD)]
    [Dictionary('CMD_QTDCOMODATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMD_QTDCOMODATO: Double read FCMD_QTDCOMODATO write FCMD_QTDCOMODATO;
    const CMD_QTDCOMODATO_Name = 'CMD_QTDCOMODATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_QTDFATURADA', ftBCD)]
    [Dictionary('CMD_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMD_QTDFATURADA: Double read FCMD_QTDFATURADA write FCMD_QTDFATURADA;
    const CMD_QTDFATURADA_Name = 'CMD_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMD_DATAALTERACAO', ftDateTime)]
    [Dictionary('CMD_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMD_DATAALTERACAO: TDateTime read FCMD_DATAALTERACAO write FCMD_DATAALTERACAO;
    const CMD_DATAALTERACAO_Name = 'CMD_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CMD_01_ID_OLD', ftInteger)]
    [Dictionary('CMD_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_01_ID_OLD: Integer read FCMD_01_ID_OLD write FCMD_01_ID_OLD;
    const CMD_01_ID_OLD_Name = 'CMD_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CMD_ID_OLD', ftInteger)]
    [Dictionary('CMD_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMD_ID_OLD: Integer read FCMD_ID_OLD write FCMD_ID_OLD;
    const CMD_ID_OLD_Name = 'CMD_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ONS_ID_OLD', ftInteger)]
    [Dictionary('ONS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ONS_ID_OLD: Integer read FONS_ID_OLD write FONS_ID_OLD;
    const ONS_ID_OLD_Name = 'ONS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ONS_01_ID_OLD', ftInteger)]
    [Dictionary('ONS_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ONS_01_ID_OLD: Integer read FONS_01_ID_OLD write FONS_01_ID_OLD;
    const ONS_01_ID_OLD_Name = 'ONS_01_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCMD_00_01)

end.
