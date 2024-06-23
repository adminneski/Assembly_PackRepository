unit express.dbo.ETQ_00;

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
  [Table('ETQ_00', '')]
  [PrimaryKey('ETQ_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ETQ_ID')]
  TDtoETQ_00 = class
  private
    { Private declarations } 
    FETQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FETQ_ESTOQUEFILIAL: Double;
    FETQ_ESTOQUEFILIALPRODUCAO: Double;
    FETQ_ESTOQUEMINIMO: Double;
    FETQ_ESTOQUEMAXIMO: Double;
    FETQ_ESTOQUECOMPRADO: Double;
    FETQ_VALORULTIMOCUSTO: Double;
    FETQ_VALORCUSTOCOMPRA: Double;
    FETQ_VALORCUSTOLIQUIDO: Double;
    FETQ_VALORCUSTOINVENTARIO: Double;
    FETQ_VALORCUSTOCOMPRAMEDIO: Double;
    FETQ_VALORCUSTOLIQUIDOMEDIO: Double;
    FETQ_VALORCUSTOINVENTARIOMEDIO: Double;
    FETQ_DATAULTIMAVENDA: TDateTime;
    FETQ_VALORULTIMAVENDA: Double;
    FETQ_QUANTIDADEVENDIDA: Double;
    FETQ_DATAULTIMACOMPRA: TDateTime;
    FETQ_VALORULTIMACOMPRA: Double;
    FETQ_QUANTIDADECOMPRADA: Double;
    FETQ_DATAALTERACAO: TDateTime;
    FETQ_DATAULTIMOFECHAMENTO: TDateTime;
    FETQ_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'ETQ_00';
     const PrimaryKey = 'ETQ_ID';
     const Sequence   = 'SEQ_ETQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_ID', ftInteger)]
    [Dictionary('ETQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_ID: Integer read FETQ_ID write FETQ_ID;
    const ETQ_ID_Name = 'ETQ_ID';

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
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;
    const ETQ_ESTOQUEFILIAL_Name = 'ETQ_ESTOQUEFILIAL';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIALPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIALPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIALPRODUCAO: Double read FETQ_ESTOQUEFILIALPRODUCAO write FETQ_ESTOQUEFILIALPRODUCAO;
    const ETQ_ESTOQUEFILIALPRODUCAO_Name = 'ETQ_ESTOQUEFILIALPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEMINIMO: Double read FETQ_ESTOQUEMINIMO write FETQ_ESTOQUEMINIMO;
    const ETQ_ESTOQUEMINIMO_Name = 'ETQ_ESTOQUEMINIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEMAXIMO: Double read FETQ_ESTOQUEMAXIMO write FETQ_ESTOQUEMAXIMO;
    const ETQ_ESTOQUEMAXIMO_Name = 'ETQ_ESTOQUEMAXIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_ESTOQUECOMPRADO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUECOMPRADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUECOMPRADO: Double read FETQ_ESTOQUECOMPRADO write FETQ_ESTOQUECOMPRADO;
    const ETQ_ESTOQUECOMPRADO_Name = 'ETQ_ESTOQUECOMPRADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_VALORULTIMOCUSTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORULTIMOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORULTIMOCUSTO: Double read FETQ_VALORULTIMOCUSTO write FETQ_VALORULTIMOCUSTO;
    const ETQ_VALORULTIMOCUSTO_Name = 'ETQ_VALORULTIMOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOCOMPRA: Double read FETQ_VALORCUSTOCOMPRA write FETQ_VALORCUSTOCOMPRA;
    const ETQ_VALORCUSTOCOMPRA_Name = 'ETQ_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOLIQUIDO: Double read FETQ_VALORCUSTOLIQUIDO write FETQ_VALORCUSTOLIQUIDO;
    const ETQ_VALORCUSTOLIQUIDO_Name = 'ETQ_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOINVENTARIO: Double read FETQ_VALORCUSTOINVENTARIO write FETQ_VALORCUSTOINVENTARIO;
    const ETQ_VALORCUSTOINVENTARIO_Name = 'ETQ_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOCOMPRAMEDIO: Double read FETQ_VALORCUSTOCOMPRAMEDIO write FETQ_VALORCUSTOCOMPRAMEDIO;
    const ETQ_VALORCUSTOCOMPRAMEDIO_Name = 'ETQ_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOLIQUIDOMEDIO: Double read FETQ_VALORCUSTOLIQUIDOMEDIO write FETQ_VALORCUSTOLIQUIDOMEDIO;
    const ETQ_VALORCUSTOLIQUIDOMEDIO_Name = 'ETQ_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOINVENTARIOMEDIO: Double read FETQ_VALORCUSTOINVENTARIOMEDIO write FETQ_VALORCUSTOINVENTARIOMEDIO;
    const ETQ_VALORCUSTOINVENTARIOMEDIO_Name = 'ETQ_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMAVENDA', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMAVENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMAVENDA: TDateTime read FETQ_DATAULTIMAVENDA write FETQ_DATAULTIMAVENDA;
    const ETQ_DATAULTIMAVENDA_Name = 'ETQ_DATAULTIMAVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_VALORULTIMAVENDA', ftBCD)]
    [Dictionary('ETQ_VALORULTIMAVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORULTIMAVENDA: Double read FETQ_VALORULTIMAVENDA write FETQ_VALORULTIMAVENDA;
    const ETQ_VALORULTIMAVENDA_Name = 'ETQ_VALORULTIMAVENDA';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDIDA', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDIDA: Double read FETQ_QUANTIDADEVENDIDA write FETQ_QUANTIDADEVENDIDA;
    const ETQ_QUANTIDADEVENDIDA_Name = 'ETQ_QUANTIDADEVENDIDA';

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMACOMPRA', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMACOMPRA', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMACOMPRA: TDateTime read FETQ_DATAULTIMACOMPRA write FETQ_DATAULTIMACOMPRA;
    const ETQ_DATAULTIMACOMPRA_Name = 'ETQ_DATAULTIMACOMPRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_VALORULTIMACOMPRA', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORULTIMACOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORULTIMACOMPRA: Double read FETQ_VALORULTIMACOMPRA write FETQ_VALORULTIMACOMPRA;
    const ETQ_VALORULTIMACOMPRA_Name = 'ETQ_VALORULTIMACOMPRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_QUANTIDADECOMPRADA', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADECOMPRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADECOMPRADA: Double read FETQ_QUANTIDADECOMPRADA write FETQ_QUANTIDADECOMPRADA;
    const ETQ_QUANTIDADECOMPRADA_Name = 'ETQ_QUANTIDADECOMPRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('ETQ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETQ_DATAALTERACAO: TDateTime read FETQ_DATAALTERACAO write FETQ_DATAALTERACAO;
    const ETQ_DATAALTERACAO_Name = 'ETQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMOFECHAMENTO', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMOFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMOFECHAMENTO: TDateTime read FETQ_DATAULTIMOFECHAMENTO write FETQ_DATAULTIMOFECHAMENTO;
    const ETQ_DATAULTIMOFECHAMENTO_Name = 'ETQ_DATAULTIMOFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ETQ_ID_OLD', ftInteger)]
    [Dictionary('ETQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_ID_OLD: Integer read FETQ_ID_OLD write FETQ_ID_OLD;
    const ETQ_ID_OLD_Name = 'ETQ_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoETQ_00)

end.
