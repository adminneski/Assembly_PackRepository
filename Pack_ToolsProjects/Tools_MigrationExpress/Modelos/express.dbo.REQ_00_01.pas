unit express.dbo.REQ_00_01;

interface

uses
  DB,
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.req_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('REQ_00_01', '')]
  [PrimaryKey('REQ_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_REQ_01_ID')]
  TDtoREQ_00_01 = class
  private
    { Private declarations } 
    FREQ_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FREQ_ID: Integer;
    FPRO_CODIGO: Integer;
    FREQ_QTDREQUISICAO: Double;
    FREQ_VALORCUSTOCOMPRA: Double;
    FREQ_VALORCUSTOLIQUIDO: Double;
    FREQ_VALORCUSTOINVENTARIO: Double;
    FREQ_VALORCUSTOCOMPRAMEDIO: Double;
    FREQ_VALORCUSTOLIQUIDOMEDIO: Double;
    FREQ_VALORCUSTOINVENTARIOMEDIO: Double;
    FREQ_DATAALTERACAO: TDateTime;
    FREQ_PRECOCUSTO: Double;
    FREQ_01_ID_OLD: Integer;
    FREQ_ID_OLD: Integer;
  public
    { Public declarations } 
    const Table      = 'REQ_00_01';
    const PrimaryKey = 'REQ_01_ID';
    const Sequence   = 'SEQ_REQ_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_01_ID', ftInteger)]
    [Dictionary('REQ_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_01_ID: Integer read FREQ_01_ID write FREQ_01_ID;
    const REQ_01_ID_Name = 'REQ_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('REQ_ID', ftInteger)]
    [ForeignKey('REQ_00_01_fk', 'REQ_ID', 'REQ_00', 'REQ_ID', SetNull, SetNull)]
    [Dictionary('REQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID: Integer read FREQ_ID write FREQ_ID;
    const REQ_ID_Name = 'REQ_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('REQ_QTDREQUISICAO', ftBCD, 18, 4)]
    [Dictionary('REQ_QTDREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_QTDREQUISICAO: Double read FREQ_QTDREQUISICAO write FREQ_QTDREQUISICAO;
    const REQ_QTDREQUISICAO_Name = 'REQ_QTDREQUISICAO';

    [Restrictions([NoValidate])]
    [Column('REQ_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('REQ_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORCUSTOCOMPRA: Double read FREQ_VALORCUSTOCOMPRA write FREQ_VALORCUSTOCOMPRA;
    const REQ_VALORCUSTOCOMPRA_Name = 'REQ_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('REQ_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('REQ_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORCUSTOLIQUIDO: Double read FREQ_VALORCUSTOLIQUIDO write FREQ_VALORCUSTOLIQUIDO;
    const REQ_VALORCUSTOLIQUIDO_Name = 'REQ_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('REQ_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('REQ_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORCUSTOINVENTARIO: Double read FREQ_VALORCUSTOINVENTARIO write FREQ_VALORCUSTOINVENTARIO;
    const REQ_VALORCUSTOINVENTARIO_Name = 'REQ_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('REQ_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('REQ_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORCUSTOCOMPRAMEDIO: Double read FREQ_VALORCUSTOCOMPRAMEDIO write FREQ_VALORCUSTOCOMPRAMEDIO;
    const REQ_VALORCUSTOCOMPRAMEDIO_Name = 'REQ_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('REQ_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('REQ_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORCUSTOLIQUIDOMEDIO: Double read FREQ_VALORCUSTOLIQUIDOMEDIO write FREQ_VALORCUSTOLIQUIDOMEDIO;
    const REQ_VALORCUSTOLIQUIDOMEDIO_Name = 'REQ_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('REQ_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('REQ_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_VALORCUSTOINVENTARIOMEDIO: Double read FREQ_VALORCUSTOINVENTARIOMEDIO write FREQ_VALORCUSTOINVENTARIOMEDIO;
    const REQ_VALORCUSTOINVENTARIOMEDIO_Name = 'REQ_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('REQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('REQ_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property REQ_DATAALTERACAO: TDateTime read FREQ_DATAALTERACAO write FREQ_DATAALTERACAO;
    const REQ_DATAALTERACAO_Name = 'REQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('REQ_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('REQ_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_PRECOCUSTO: Double read FREQ_PRECOCUSTO write FREQ_PRECOCUSTO;
    const REQ_PRECOCUSTO_Name = 'REQ_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('REQ_01_ID_OLD', ftInteger)]
    [Dictionary('REQ_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_01_ID_OLD: Integer read FREQ_01_ID_OLD write FREQ_01_ID_OLD;
    const REQ_01_ID_OLD_Name = 'REQ_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('REQ_ID_OLD', ftInteger)]
    [Dictionary('REQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID_OLD: Integer read FREQ_ID_OLD write FREQ_ID_OLD;
    const REQ_ID_OLD_Name = 'REQ_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREQ_00_01)

end.
