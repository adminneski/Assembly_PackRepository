unit express.dbo.CPM_COMPOSICAOPRODUTOFINAL;

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
  [Table('CPM_ComposicaoProdutoFinal', '')]
  TDtoCPM_ComposicaoProdutoFinal = class
  private
    { Private declarations } 
    FCPM_ID: Integer;
    FCPM_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRM_CODIGO: Integer;
    FPRM_DESCRICAO: String;
    FPRM_QTDCOMPOSICAO: Double;
    FSGM_CODIGO: String;
    FSGM_SIGLA: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FPRO_QUANTIDADEUNCAIXA: Double;
    FETQ_VALORCUSTOCOMPRA: Double;
    FETQ_VALORCUSTOLIQUIDO: Double;
    FETQ_VALORCUSTOINVENTARIO: Double;
    FETQ_VALORCUSTOCOMPRAMEDIO: Double;
    FETQ_VALORCUSTOLIQUIDOMEDIO: Double;
    FETQ_VALORCUSTOINVENTARIOMEDIO: Double;
    FPRO_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'CPM_ComposicaoProdutoFinal';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPM_ID', ftInteger)]
    [Dictionary('CPM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_ID: Integer read FCPM_ID write FCPM_ID;
    const CPM_ID_Name = 'CPM_ID';

    [Restrictions([NoValidate])]
    [Column('CPM_01_ID', ftInteger)]
    [Dictionary('CPM_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_01_ID: Integer read FCPM_01_ID write FCPM_01_ID;
    const CPM_01_ID_Name = 'CPM_01_ID';

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
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRM_CODIGO', ftInteger)]
    [Dictionary('PRM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRM_CODIGO: Integer read FPRM_CODIGO write FPRM_CODIGO;
    const PRM_CODIGO_Name = 'PRM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRM_DESCRICAO', ftString, 100)]
    [Dictionary('PRM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRM_DESCRICAO: String read FPRM_DESCRICAO write FPRM_DESCRICAO;
    const PRM_DESCRICAO_Name = 'PRM_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRM_QTDCOMPOSICAO', ftBCD, 18, 4)]
    [Dictionary('PRM_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRM_QTDCOMPOSICAO: Double read FPRM_QTDCOMPOSICAO write FPRM_QTDCOMPOSICAO;
    const PRM_QTDCOMPOSICAO_Name = 'PRM_QTDCOMPOSICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

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

    [Restrictions([NoValidate])]
    [Column('PRO_QUANTIDADEUNCAIXA', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADEUNCAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADEUNCAIXA: Double read FPRO_QUANTIDADEUNCAIXA write FPRO_QUANTIDADEUNCAIXA;
    const PRO_QUANTIDADEUNCAIXA_Name = 'PRO_QUANTIDADEUNCAIXA';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOCOMPRA: Double read FETQ_VALORCUSTOCOMPRA write FETQ_VALORCUSTOCOMPRA;
    const ETQ_VALORCUSTOCOMPRA_Name = 'ETQ_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOLIQUIDO: Double read FETQ_VALORCUSTOLIQUIDO write FETQ_VALORCUSTOLIQUIDO;
    const ETQ_VALORCUSTOLIQUIDO_Name = 'ETQ_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
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
    [Column('PRO_OBSERVACAO', ftString, 300)]
    [Dictionary('PRO_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_OBSERVACAO: String read FPRO_OBSERVACAO write FPRO_OBSERVACAO;
    const PRO_OBSERVACAO_Name = 'PRO_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPM_ComposicaoProdutoFinal)

end.
