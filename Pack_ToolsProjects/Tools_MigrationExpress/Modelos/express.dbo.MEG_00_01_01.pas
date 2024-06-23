unit express.dbo.MEG_00_01_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.meg_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MEG_00_01_01', '')]
  [PrimaryKey('MEG_01_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MEG_01_01_ID')]
  TDtoMEG_00_01_01 = class
  private
    { Private declarations } 
    FMEG_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FMEG_01_ID: Integer;
    FMEG_ID: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FMEG_QTDENTRADA: Double;
    FMEG_DATAALTERACAO: TDateTime;
    FMEG_ID_OLD: Integer;
    FMEG_01_ID_OLD: Integer;
    FMEG_01_01_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MEG_00_01_01';
    const PrimaryKey = 'MEG_01_01_ID';
    const Sequence   = 'SEQ_MEG_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_01_01_ID', ftInteger)]
    [Dictionary('MEG_01_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_01_01_ID: Integer read FMEG_01_01_ID write FMEG_01_01_ID;
    const MEG_01_01_ID_Name = 'MEG_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_01_ID', ftInteger)]
    [Dictionary('MEG_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_01_ID: Integer read FMEG_01_ID write FMEG_01_ID;
    const MEG_01_ID_Name = 'MEG_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_ID', ftInteger)]
    [ForeignKey('MEG_00_01_01_fk', 'MEG_ID', 'MEG_00', 'MEG_ID', SetNull, SetNull)]
    [Dictionary('MEG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_ID: Integer read FMEG_ID write FMEG_ID;
    const MEG_ID_Name = 'MEG_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 3)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('MEG_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MEG_QTDENTRADA: Double read FMEG_QTDENTRADA write FMEG_QTDENTRADA;
    const MEG_QTDENTRADA_Name = 'MEG_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_DATAALTERACAO', ftDateTime)]
    [Dictionary('MEG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MEG_DATAALTERACAO: TDateTime read FMEG_DATAALTERACAO write FMEG_DATAALTERACAO;
    const MEG_DATAALTERACAO_Name = 'MEG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MEG_ID_OLD', ftInteger)]
    [Dictionary('MEG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_ID_OLD: Integer read FMEG_ID_OLD write FMEG_ID_OLD;
    const MEG_ID_OLD_Name = 'MEG_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MEG_01_ID_OLD', ftInteger)]
    [Dictionary('MEG_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_01_ID_OLD: Integer read FMEG_01_ID_OLD write FMEG_01_ID_OLD;
    const MEG_01_ID_OLD_Name = 'MEG_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MEG_01_01_ID_OLD', ftInteger)]
    [Dictionary('MEG_01_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_01_01_ID_OLD: Integer read FMEG_01_01_ID_OLD write FMEG_01_01_ID_OLD;
    const MEG_01_01_ID_OLD_Name = 'MEG_01_01_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMEG_00_01_01)

end.
