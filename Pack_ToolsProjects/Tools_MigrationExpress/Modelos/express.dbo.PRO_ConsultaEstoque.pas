unit express.dbo.PRO_CONSULTAESTOQUE;

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
  [Table('PRO_ConsultaEstoque', '')]
  TDtoPRO_ConsultaEstoque = class
  private
    { Private declarations } 
    FETQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FETQ_ESTOQUEFILIAL: Double;
    FETQ_ESTOQUEFILIALPRODUCAO: Double;
    FPRO_ESTOQUEMINIMO: Double;
    FPRO_ESTOQUEMAXIMO: Double;
    FETQ_ESTOQUECOMPRADO: Double;
    FETQ_VALORULTIMOCUSTO: Double;
    FETQ_VALORCUSTOCOMPRA: Double;
    FETQ_VALORCUSTOLIQUIDO: Double;
    FETQ_VALORCUSTOINVENTARIO: Double;
    FETQ_VALORCUSTOCOMPRAMEDIO: Double;
    FETQ_VALORCUSTOLIQUIDOMEDIO: Double;
    FETQ_VALORCUSTOINVENTARIOMEDIO: Double;
    FETQ_VALORULTIMAVENDA: Double;
    FETQ_VALORULTIMACOMPRA: Double;
    FETQ_QUANTIDADECOMPRADA: Double;
    FETQ_DATAULTIMAVENDA: TDateTime;
    FETQ_DATAULTIMACOMPRA: TDateTime;
    FPRO_DESCRICAO: String;
    FSGM_CODIGO: String;
    FGRP_CODIGO: Integer;
    FSGP_CODIGO: Integer;
    FPRO_EMBALAGEM: String;
    FPRO_CODIGOBARRA1: String;
    FPRO_CODIGOBARRA2: String;
    FPRO_CODIGOBARRA3: String;
    FSGM_DESCRICAO: String;
    FSGP_DESCRICAO: String;
    FSGP_SUBGRUPO: String;
    FGRP_DESCRICAO: String;
    FGRP_GRUPO: String;
    FTAB_CODIGO: Integer;
    FTAB_DESCRICAO: String;
    FPRO_PRECOPEDIDO: Double;
    FETQ_ESTOQUEMAXIMO: Double;
    FETQ_ESTOQUEMINIMO: Double;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_REFERENCIAINTERNA: String;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'PRO_ConsultaEstoque';

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

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMINIMO: Double read FPRO_ESTOQUEMINIMO write FPRO_ESTOQUEMINIMO;
    const PRO_ESTOQUEMINIMO_Name = 'PRO_ESTOQUEMINIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMAXIMO: Double read FPRO_ESTOQUEMAXIMO write FPRO_ESTOQUEMAXIMO;
    const PRO_ESTOQUEMAXIMO_Name = 'PRO_ESTOQUEMAXIMO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_VALORULTIMAVENDA', ftBCD)]
    [Dictionary('ETQ_VALORULTIMAVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORULTIMAVENDA: Double read FETQ_VALORULTIMAVENDA write FETQ_VALORULTIMAVENDA;
    const ETQ_VALORULTIMAVENDA_Name = 'ETQ_VALORULTIMAVENDA';

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

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMAVENDA', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMAVENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMAVENDA: TDateTime read FETQ_DATAULTIMAVENDA write FETQ_DATAULTIMAVENDA;
    const ETQ_DATAULTIMAVENDA_Name = 'ETQ_DATAULTIMAVENDA';

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMACOMPRA', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMACOMPRA', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMACOMPRA: TDateTime read FETQ_DATAULTIMACOMPRA write FETQ_DATAULTIMACOMPRA;
    const ETQ_DATAULTIMACOMPRA_Name = 'ETQ_DATAULTIMACOMPRA';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA1', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA1: String read FPRO_CODIGOBARRA1 write FPRO_CODIGOBARRA1;
    const PRO_CODIGOBARRA1_Name = 'PRO_CODIGOBARRA1';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA2', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA2: String read FPRO_CODIGOBARRA2 write FPRO_CODIGOBARRA2;
    const PRO_CODIGOBARRA2_Name = 'PRO_CODIGOBARRA2';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA3', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA3: String read FPRO_CODIGOBARRA3 write FPRO_CODIGOBARRA3;
    const PRO_CODIGOBARRA3_Name = 'PRO_CODIGOBARRA3';

    [Restrictions([NoValidate])]
    [Column('SGM_DESCRICAO', ftString, 30)]
    [Dictionary('SGM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_DESCRICAO: String read FSGM_DESCRICAO write FSGM_DESCRICAO;
    const SGM_DESCRICAO_Name = 'SGM_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TAB_DESCRICAO', ftString, 30)]
    [Dictionary('TAB_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TAB_DESCRICAO: String read FTAB_DESCRICAO write FTAB_DESCRICAO;
    const TAB_DESCRICAO_Name = 'TAB_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOPEDIDO', ftBCD)]
    [Dictionary('PRO_PRECOPEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOPEDIDO: Double read FPRO_PRECOPEDIDO write FPRO_PRECOPEDIDO;
    const PRO_PRECOPEDIDO_Name = 'PRO_PRECOPEDIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEMAXIMO: Double read FETQ_ESTOQUEMAXIMO write FETQ_ESTOQUEMAXIMO;
    const ETQ_ESTOQUEMAXIMO_Name = 'ETQ_ESTOQUEMAXIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEMINIMO: Double read FETQ_ESTOQUEMINIMO write FETQ_ESTOQUEMINIMO;
    const ETQ_ESTOQUEMINIMO_Name = 'ETQ_ESTOQUEMINIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('FAB_CODIGO', ftInteger)]
    [Dictionary('FAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAB_CODIGO: Integer read FFAB_CODIGO write FFAB_CODIGO;
    const FAB_CODIGO_Name = 'FAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_NOME', ftString, 100)]
    [Dictionary('FAB_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAB_NOME: String read FFAB_NOME write FFAB_NOME;
    const FAB_NOME_Name = 'FAB_NOME';

    [Restrictions([NoValidate])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_DESCRICAO', ftString, 30)]
    [Dictionary('LCZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_DESCRICAO: String read FLCZ_DESCRICAO write FLCZ_DESCRICAO;
    const LCZ_DESCRICAO_Name = 'LCZ_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_ConsultaEstoque)

end.
