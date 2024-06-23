unit express.dbo.INV_00;

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
  [Table('INV_00', '')]
  [PrimaryKey('INV_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_INV_ID')]
  TDtoINV_00 = class
  private
    { Private declarations } 
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FINV_DATAFECHAMENTO: TDateTime;
    FINV_DATADIAFECHAMENTO: TDateTime;
    FINV_SALDOFECHAMENTO: Double;
    FINV_VALORICMS: Double;
    FINV_VALORIPI: Double;
    FINV_VALORPIS: Double;
    FINV_VALORCOFINS: Double;
    FINV_VALORCUSTOCOMPRA: Double;
    FINV_VALORCUSTOINVENTARIO: Double;
    FINV_VALORCUSTOLIQUIDO: Double;
    FINV_VALORCUSTOCOMPRAMEDIO: Double;
    FINV_VALORCUSTOINVENTARIOMEDIO: Double;
    FINV_VALORCUSTOLIQUIDOMEDIO: Double;
    FINV_QTDENTRADA: Double;
    FINV_QTDSAIDA: Double;
    FINV_QTDOUTRASENTRADAS: Double;
    FINV_QTDOUTRASAIDAS: Double;
    FINV_QTDPRODUZIDAENTRADA: Double;
    FINV_QTDPRODUZIDASAIDA: Double;
    FINV_DESATIVADO: String;
    FINV_DATAALTERACAO: TDateTime;
    FINV_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'INV_00';
     const PrimaryKey = 'INV_ID';
     const Sequence   = 'SEQ_INV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ID', ftInteger)]
    [Dictionary('INV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ID: Integer read FINV_ID write FINV_ID;
    const INV_ID_Name = 'INV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INV_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property INV_DATAFECHAMENTO: TDateTime read FINV_DATAFECHAMENTO write FINV_DATAFECHAMENTO;
    const INV_DATAFECHAMENTO_Name = 'INV_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('INV_DATADIAFECHAMENTO', ftDateTime)]
    [Dictionary('INV_DATADIAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATADIAFECHAMENTO: TDateTime read FINV_DATADIAFECHAMENTO write FINV_DATADIAFECHAMENTO;
    const INV_DATADIAFECHAMENTO_Name = 'INV_DATADIAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('INV_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_SALDOFECHAMENTO: Double read FINV_SALDOFECHAMENTO write FINV_SALDOFECHAMENTO;
    const INV_SALDOFECHAMENTO_Name = 'INV_SALDOFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORICMS', ftBCD, 18, 4)]
    [Dictionary('INV_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORICMS: Double read FINV_VALORICMS write FINV_VALORICMS;
    const INV_VALORICMS_Name = 'INV_VALORICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORIPI', ftBCD, 18, 4)]
    [Dictionary('INV_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORIPI: Double read FINV_VALORIPI write FINV_VALORIPI;
    const INV_VALORIPI_Name = 'INV_VALORIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORPIS', ftBCD, 18, 4)]
    [Dictionary('INV_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORPIS: Double read FINV_VALORPIS write FINV_VALORPIS;
    const INV_VALORPIS_Name = 'INV_VALORPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCOFINS', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCOFINS: Double read FINV_VALORCOFINS write FINV_VALORCOFINS;
    const INV_VALORCOFINS_Name = 'INV_VALORCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRA: Double read FINV_VALORCUSTOCOMPRA write FINV_VALORCUSTOCOMPRA;
    const INV_VALORCUSTOCOMPRA_Name = 'INV_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIO: Double read FINV_VALORCUSTOINVENTARIO write FINV_VALORCUSTOINVENTARIO;
    const INV_VALORCUSTOINVENTARIO_Name = 'INV_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOLIQUIDO: Double read FINV_VALORCUSTOLIQUIDO write FINV_VALORCUSTOLIQUIDO;
    const INV_VALORCUSTOLIQUIDO_Name = 'INV_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRAMEDIO: Double read FINV_VALORCUSTOCOMPRAMEDIO write FINV_VALORCUSTOCOMPRAMEDIO;
    const INV_VALORCUSTOCOMPRAMEDIO_Name = 'INV_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIOMEDIO: Double read FINV_VALORCUSTOINVENTARIOMEDIO write FINV_VALORCUSTOINVENTARIOMEDIO;
    const INV_VALORCUSTOINVENTARIOMEDIO_Name = 'INV_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('INV_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOLIQUIDOMEDIO: Double read FINV_VALORCUSTOLIQUIDOMEDIO write FINV_VALORCUSTOLIQUIDOMEDIO;
    const INV_VALORCUSTOLIQUIDOMEDIO_Name = 'INV_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDENTRADA: Double read FINV_QTDENTRADA write FINV_QTDENTRADA;
    const INV_QTDENTRADA_Name = 'INV_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDSAIDA: Double read FINV_QTDSAIDA write FINV_QTDSAIDA;
    const INV_QTDSAIDA_Name = 'INV_QTDSAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDOUTRASENTRADAS', ftBCD, 18, 4)]
    [Dictionary('INV_QTDOUTRASENTRADAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDOUTRASENTRADAS: Double read FINV_QTDOUTRASENTRADAS write FINV_QTDOUTRASENTRADAS;
    const INV_QTDOUTRASENTRADAS_Name = 'INV_QTDOUTRASENTRADAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDOUTRASAIDAS', ftBCD, 18, 4)]
    [Dictionary('INV_QTDOUTRASAIDAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDOUTRASAIDAS: Double read FINV_QTDOUTRASAIDAS write FINV_QTDOUTRASAIDAS;
    const INV_QTDOUTRASAIDAS_Name = 'INV_QTDOUTRASAIDAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDPRODUZIDAENTRADA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDPRODUZIDAENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDPRODUZIDAENTRADA: Double read FINV_QTDPRODUZIDAENTRADA write FINV_QTDPRODUZIDAENTRADA;
    const INV_QTDPRODUZIDAENTRADA_Name = 'INV_QTDPRODUZIDAENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_QTDPRODUZIDASAIDA', ftBCD, 18, 4)]
    [Dictionary('INV_QTDPRODUZIDASAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDPRODUZIDASAIDA: Double read FINV_QTDPRODUZIDASAIDA write FINV_QTDPRODUZIDASAIDA;
    const INV_QTDPRODUZIDASAIDA_Name = 'INV_QTDPRODUZIDASAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_DESATIVADO', ftString, 1)]
    [Dictionary('INV_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_DESATIVADO: String read FINV_DESATIVADO write FINV_DESATIVADO;
    const INV_DESATIVADO_Name = 'INV_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('INV_DATAALTERACAO', ftDateTime)]
    [Dictionary('INV_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATAALTERACAO: TDateTime read FINV_DATAALTERACAO write FINV_DATAALTERACAO;
    const INV_DATAALTERACAO_Name = 'INV_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('INV_ID_OLD', ftInteger)]
    [Dictionary('INV_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ID_OLD: Integer read FINV_ID_OLD write FINV_ID_OLD;
    const INV_ID_OLD_Name = 'INV_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoINV_00)

end.
