unit express.dbo.PDC_00_02_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.pdc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PDC_00_02_01', '')]
  [PrimaryKey('PDC_02_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDC_02_01_ID')]
  TDtoPDC_00_02_01 = class
  private
    { Private declarations } 
    FPDC_02_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDC_02_ID: Integer;
    FPDC_ID: Integer;
    FPRO_CODIGO: Integer;
    FPRM_CODIGO: Integer;
    FPDC_QTDCOMPOSICAO: Double;
    FPDC_DATAALTERACAO: TDateTime;
    FPDC_02_01_ID_OLD: Integer;
    FPDC_02_ID_OLD: Integer;
    FPDC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PDC_00_02_01';
    const PrimaryKey = 'PDC_02_01_ID';
    const Sequence   = 'SEQ_PDC_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_02_01_ID', ftInteger)]
    [Dictionary('PDC_02_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_01_ID: Integer read FPDC_02_01_ID write FPDC_02_01_ID;
    const PDC_02_01_ID_Name = 'PDC_02_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_02_ID', ftInteger)]
    [Dictionary('PDC_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_ID: Integer read FPDC_02_ID write FPDC_02_ID;
    const PDC_02_ID_Name = 'PDC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_ID', ftInteger)]
    [ForeignKey('PDC_00_02_01_fk', 'PDC_ID', 'PDC_00', 'PDC_ID', SetNull, SetNull)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRM_CODIGO', ftInteger)]
    [Dictionary('PRM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRM_CODIGO: Integer read FPRM_CODIGO write FPRM_CODIGO;
    const PRM_CODIGO_Name = 'PRM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_QTDCOMPOSICAO', ftBCD, 18, 4)]
    [Dictionary('PDC_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_QTDCOMPOSICAO: Double read FPDC_QTDCOMPOSICAO write FPDC_QTDCOMPOSICAO;
    const PDC_QTDCOMPOSICAO_Name = 'PDC_QTDCOMPOSICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDC_DATAALTERACAO: TDateTime read FPDC_DATAALTERACAO write FPDC_DATAALTERACAO;
    const PDC_DATAALTERACAO_Name = 'PDC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_02_01_ID_OLD', ftInteger)]
    [Dictionary('PDC_02_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_01_ID_OLD: Integer read FPDC_02_01_ID_OLD write FPDC_02_01_ID_OLD;
    const PDC_02_01_ID_OLD_Name = 'PDC_02_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDC_02_ID_OLD', ftInteger)]
    [Dictionary('PDC_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_ID_OLD: Integer read FPDC_02_ID_OLD write FPDC_02_ID_OLD;
    const PDC_02_ID_OLD_Name = 'PDC_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDC_ID_OLD', ftInteger)]
    [Dictionary('PDC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID_OLD: Integer read FPDC_ID_OLD write FPDC_ID_OLD;
    const PDC_ID_OLD_Name = 'PDC_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoPDC_00_02_01)

end.
