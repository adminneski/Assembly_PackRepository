unit express.dbo.AJU_00;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('AJU_00', '')]
  [PrimaryKey('AJU_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AJU_ID')]
  TDtoAJU_00 = class
  private
    { Private declarations } 
    FAJU_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FAJU_DATALANCAMENTO: TDateTime;
    FAJU_SALDOFINALDIA: Double;
    FAJU_VALORCUSTOCOMPRA: Double;
    FAJU_VALORCUSTOLIQUIDO: Double;
    FAJU_VALORCUSTOINVENTARIO: Double;
    FAJU_VALORCUSTOCOMPRAMEDIO: Double;
    FAJU_VALORCUSTOLIQUIDOMEDIO: Double;
    FAJU_VALORCUSTOINVENTARIOMEDIO: Double;
    FAJU_ID_OLD: Integer;
    FAJU_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'AJU_00';
     const PrimaryKey = 'AJU_ID';
     const Sequence   = 'SEQ_AJU_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('AJU_ID', ftInteger)]
    [Dictionary('AJU_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property AJU_ID: Integer read FAJU_ID write FAJU_ID;
    const AJU_ID_Name = 'AJU_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AJU_DATALANCAMENTO', ftDateTime)]
    [Dictionary('AJU_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property AJU_DATALANCAMENTO: TDateTime read FAJU_DATALANCAMENTO write FAJU_DATALANCAMENTO;
    const AJU_DATALANCAMENTO_Name = 'AJU_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('AJU_SALDOFINALDIA', ftBCD, 18, 4)]
    [Dictionary('AJU_SALDOFINALDIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_SALDOFINALDIA: Double read FAJU_SALDOFINALDIA write FAJU_SALDOFINALDIA;
    const AJU_SALDOFINALDIA_Name = 'AJU_SALDOFINALDIA';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOCOMPRA: Double read FAJU_VALORCUSTOCOMPRA write FAJU_VALORCUSTOCOMPRA;
    const AJU_VALORCUSTOCOMPRA_Name = 'AJU_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOLIQUIDO: Double read FAJU_VALORCUSTOLIQUIDO write FAJU_VALORCUSTOLIQUIDO;
    const AJU_VALORCUSTOLIQUIDO_Name = 'AJU_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOINVENTARIO: Double read FAJU_VALORCUSTOINVENTARIO write FAJU_VALORCUSTOINVENTARIO;
    const AJU_VALORCUSTOINVENTARIO_Name = 'AJU_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOCOMPRAMEDIO: Double read FAJU_VALORCUSTOCOMPRAMEDIO write FAJU_VALORCUSTOCOMPRAMEDIO;
    const AJU_VALORCUSTOCOMPRAMEDIO_Name = 'AJU_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOLIQUIDOMEDIO: Double read FAJU_VALORCUSTOLIQUIDOMEDIO write FAJU_VALORCUSTOLIQUIDOMEDIO;
    const AJU_VALORCUSTOLIQUIDOMEDIO_Name = 'AJU_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOINVENTARIOMEDIO: Double read FAJU_VALORCUSTOINVENTARIOMEDIO write FAJU_VALORCUSTOINVENTARIOMEDIO;
    const AJU_VALORCUSTOINVENTARIOMEDIO_Name = 'AJU_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('AJU_ID_OLD', ftInteger)]
    [Dictionary('AJU_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property AJU_ID_OLD: Integer read FAJU_ID_OLD write FAJU_ID_OLD;
    const AJU_ID_OLD_Name = 'AJU_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('AJU_DATAALTERACAO', ftDateTime)]
    [Dictionary('AJU_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AJU_DATAALTERACAO: TDateTime read FAJU_DATAALTERACAO write FAJU_DATAALTERACAO;
    const AJU_DATAALTERACAO_Name = 'AJU_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAJU_00)

end.
