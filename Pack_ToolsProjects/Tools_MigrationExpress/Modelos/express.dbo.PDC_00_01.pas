unit express.dbo.PDC_00_01;

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
  [Table('PDC_00_01', '')]
  [PrimaryKey('PDC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDC_01_ID')]
  TDtoPDC_00_01 = class
  private
    { Private declarations } 
    FPDC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDC_ID: Integer;
    FPRO_CODIGO: Integer;
    FPDC_QTDPRODUCAO: Double;
    FPDC_PRECOCUSTO: Double;
    FPDC_DATAALTERACAO: TDateTime;
    FPDC_01_ID_OLD: Integer;
    FPDC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PDC_00_01';
    const PrimaryKey = 'PDC_01_ID';
    const Sequence   = 'SEQ_PDC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_01_ID', ftInteger)]
    [Dictionary('PDC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_01_ID: Integer read FPDC_01_ID write FPDC_01_ID;
    const PDC_01_ID_Name = 'PDC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PDC_ID', ftInteger)]
    [ForeignKey('PDC_00_01_fk', 'PDC_ID', 'PDC_00', 'PDC_ID', SetNull, SetNull)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PDC_QTDPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('PDC_QTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_QTDPRODUCAO: Double read FPDC_QTDPRODUCAO write FPDC_QTDPRODUCAO;
    const PDC_QTDPRODUCAO_Name = 'PDC_QTDPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PDC_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PDC_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_PRECOCUSTO: Double read FPDC_PRECOCUSTO write FPDC_PRECOCUSTO;
    const PDC_PRECOCUSTO_Name = 'PDC_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('PDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDC_DATAALTERACAO: TDateTime read FPDC_DATAALTERACAO write FPDC_DATAALTERACAO;
    const PDC_DATAALTERACAO_Name = 'PDC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_01_ID_OLD', ftInteger)]
    [Dictionary('PDC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_01_ID_OLD: Integer read FPDC_01_ID_OLD write FPDC_01_ID_OLD;
    const PDC_01_ID_OLD_Name = 'PDC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDC_ID_OLD', ftInteger)]
    [Dictionary('PDC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID_OLD: Integer read FPDC_ID_OLD write FPDC_ID_OLD;
    const PDC_ID_OLD_Name = 'PDC_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoPDC_00_01)

end.
