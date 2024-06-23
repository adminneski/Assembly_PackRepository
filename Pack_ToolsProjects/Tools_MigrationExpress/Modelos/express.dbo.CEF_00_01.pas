unit express.dbo.CEF_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cef_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CEF_00_01', '')]
  [PrimaryKey('CEF_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CEF_01_ID')]
  TDtoCEF_00_01 = class
  private
    { Private declarations } 
    FCEF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCEF_ID: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FCEF_QTDENTREGUE: Double;
    FCEF_DATAALTERACAO: TDateTime;
    FCEF_01_ID_OLD: Integer;
    FCEF_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CEF_00_01';
    const PrimaryKey = 'CEF_01_ID';
    const Sequence   = 'SEQ_CEF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_01_ID', ftInteger)]
    [Dictionary('CEF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_01_ID: Integer read FCEF_01_ID write FCEF_01_ID;
    const CEF_01_ID_Name = 'CEF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_ID', ftInteger)]
    [ForeignKey('CEF_00_01_fk', 'CEF_ID', 'CEF_00', 'CEF_ID', SetNull, SetNull)]
    [Dictionary('CEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_ID: Integer read FCEF_ID write FCEF_ID;
    const CEF_ID_Name = 'CEF_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_QTDENTREGUE', ftBCD, 18, 4)]
    [Dictionary('CEF_QTDENTREGUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CEF_QTDENTREGUE: Double read FCEF_QTDENTREGUE write FCEF_QTDENTREGUE;
    const CEF_QTDENTREGUE_Name = 'CEF_QTDENTREGUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CEF_DATAALTERACAO: TDateTime read FCEF_DATAALTERACAO write FCEF_DATAALTERACAO;
    const CEF_DATAALTERACAO_Name = 'CEF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CEF_01_ID_OLD', ftInteger)]
    [Dictionary('CEF_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_01_ID_OLD: Integer read FCEF_01_ID_OLD write FCEF_01_ID_OLD;
    const CEF_01_ID_OLD_Name = 'CEF_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CEF_ID_OLD', ftInteger)]
    [Dictionary('CEF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_ID_OLD: Integer read FCEF_ID_OLD write FCEF_ID_OLD;
    const CEF_ID_OLD_Name = 'CEF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCEF_00_01)

end.
