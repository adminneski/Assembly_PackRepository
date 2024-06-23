unit express.dbo.PDC_00_03;

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
  [Table('PDC_00_03', '')]
  [PrimaryKey('PDC_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDC_03_ID')]
  TDtoPDC_00_03 = class
  private
    { Private declarations }
    FPDC_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDC_ID: Integer;
    FPRO_CODIGO: Integer;
    FPDC_QTDPRODUCAO: Double;
    FPDC_PRECOCUSTO: Double;
    FPDC_DATAALTERACAO: TDateTime;
    FPDC_03_ID_OLD: Integer;
    FPDC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PDC_00_03';
    const PrimaryKey = 'PDC_03_ID';
    const Sequence   = 'SEQ_PDC_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_03_ID', ftInteger)]
    [Dictionary('PDC_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_03_ID: Integer read FPDC_03_ID write FPDC_03_ID;
    const PDC_03_ID_Name = 'PDC_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_ID', ftInteger)]
    [ForeignKey('PDC_00_03_fk', 'PDC_ID', 'PDC_00', 'PDC_ID', SetNull, SetNull)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_QTDPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('PDC_QTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_QTDPRODUCAO: Double read FPDC_QTDPRODUCAO write FPDC_QTDPRODUCAO;
    const PDC_QTDPRODUCAO_Name = 'PDC_QTDPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PDC_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_PRECOCUSTO: Double read FPDC_PRECOCUSTO write FPDC_PRECOCUSTO;
    const PDC_PRECOCUSTO_Name = 'PDC_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDC_DATAALTERACAO: TDateTime read FPDC_DATAALTERACAO write FPDC_DATAALTERACAO;
    const PDC_DATAALTERACAO_Name = 'PDC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_03_ID_OLD', ftInteger)]
    [Dictionary('PDC_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_03_ID_OLD: Integer read FPDC_03_ID_OLD write FPDC_03_ID_OLD;
    const PDC_03_ID_OLD_Name = 'PDC_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDC_ID_OLD', ftInteger)]
    [Dictionary('PDC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID_OLD: Integer read FPDC_ID_OLD write FPDC_ID_OLD;
    const PDC_ID_OLD_Name = 'PDC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDC_00_03)

end.
