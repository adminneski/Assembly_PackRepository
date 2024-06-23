unit express.dbo.DRQ_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.drq_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('DRQ_00_01', '')]
  [PrimaryKey('DRQ_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DRQ_01_ID')]
  TDtoDRQ_00_01 = class
  private
    { Private declarations } 
    FDRQ_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FDRQ_ID: Integer;
    FPRO_CODIGO: Integer;
    FDRQ_QTDDEVOLUCAO: Double;
    FDRQ_VALORCUSTOCOMPRA: Double;
    FDRQ_VALORCUSTOLIQUIDO: Double;
    FDRQ_VALORCUSTOINVENTARIO: Double;
    FDRQ_VALORCUSTOCOMPRAMEDIO: Double;
    FDRQ_VALORCUSTOLIQUIDOMEDIO: Double;
    FDRQ_VALORCUSTOINVENTARIOMEDIO: Double;
    FDRQ_DATAALTERACAO: TDateTime;
    FDRQ_PRECOCUSTO: Double;
    FDRQ_01_ID_OLD: Integer;
    FDRQ_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'DRQ_00_01';
    const PrimaryKey = 'DRQ_01_ID';
    const Sequence   = 'SEQ_DRQ_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('DRQ_01_ID', ftInteger)]
    [Dictionary('DRQ_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DRQ_01_ID: Integer read FDRQ_01_ID write FDRQ_01_ID;
    const DRQ_01_ID_Name = 'DRQ_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DRQ_ID', ftInteger)]
    [ForeignKey('DRQ_00_01_fk', 'DRQ_ID', 'DRQ_00', 'DRQ_ID', SetNull, SetNull)]
    [Dictionary('DRQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DRQ_ID: Integer read FDRQ_ID write FDRQ_ID;
    const DRQ_ID_Name = 'DRQ_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DRQ_QTDDEVOLUCAO', ftBCD, 18, 4)]
    [Dictionary('DRQ_QTDDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_QTDDEVOLUCAO: Double read FDRQ_QTDDEVOLUCAO write FDRQ_QTDDEVOLUCAO;
    const DRQ_QTDDEVOLUCAO_Name = 'DRQ_QTDDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('DRQ_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('DRQ_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_VALORCUSTOCOMPRA: Double read FDRQ_VALORCUSTOCOMPRA write FDRQ_VALORCUSTOCOMPRA;
    const DRQ_VALORCUSTOCOMPRA_Name = 'DRQ_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('DRQ_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('DRQ_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_VALORCUSTOLIQUIDO: Double read FDRQ_VALORCUSTOLIQUIDO write FDRQ_VALORCUSTOLIQUIDO;
    const DRQ_VALORCUSTOLIQUIDO_Name = 'DRQ_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('DRQ_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('DRQ_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_VALORCUSTOINVENTARIO: Double read FDRQ_VALORCUSTOINVENTARIO write FDRQ_VALORCUSTOINVENTARIO;
    const DRQ_VALORCUSTOINVENTARIO_Name = 'DRQ_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('DRQ_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('DRQ_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_VALORCUSTOCOMPRAMEDIO: Double read FDRQ_VALORCUSTOCOMPRAMEDIO write FDRQ_VALORCUSTOCOMPRAMEDIO;
    const DRQ_VALORCUSTOCOMPRAMEDIO_Name = 'DRQ_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('DRQ_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('DRQ_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_VALORCUSTOLIQUIDOMEDIO: Double read FDRQ_VALORCUSTOLIQUIDOMEDIO write FDRQ_VALORCUSTOLIQUIDOMEDIO;
    const DRQ_VALORCUSTOLIQUIDOMEDIO_Name = 'DRQ_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('DRQ_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('DRQ_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_VALORCUSTOINVENTARIOMEDIO: Double read FDRQ_VALORCUSTOINVENTARIOMEDIO write FDRQ_VALORCUSTOINVENTARIOMEDIO;
    const DRQ_VALORCUSTOINVENTARIOMEDIO_Name = 'DRQ_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('DRQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('DRQ_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property DRQ_DATAALTERACAO: TDateTime read FDRQ_DATAALTERACAO write FDRQ_DATAALTERACAO;
    const DRQ_DATAALTERACAO_Name = 'DRQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DRQ_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('DRQ_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_PRECOCUSTO: Double read FDRQ_PRECOCUSTO write FDRQ_PRECOCUSTO;
    const DRQ_PRECOCUSTO_Name = 'DRQ_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('DRQ_01_ID_OLD', ftInteger)]
    [Dictionary('DRQ_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DRQ_01_ID_OLD: Integer read FDRQ_01_ID_OLD write FDRQ_01_ID_OLD;
    const DRQ_01_ID_OLD_Name = 'DRQ_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('DRQ_ID_OLD', ftInteger)]
    [Dictionary('DRQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DRQ_ID_OLD: Integer read FDRQ_ID_OLD write FDRQ_ID_OLD;
    const DRQ_ID_OLD_Name = 'DRQ_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDRQ_00_01)

end.
