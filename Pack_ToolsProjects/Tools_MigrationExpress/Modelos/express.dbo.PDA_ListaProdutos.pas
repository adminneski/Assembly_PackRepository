unit express.dbo.PDA_LISTAPRODUTOS;

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
  [Table('PDA_ListaProdutos', '')]
  TDtoPDA_ListaProdutos = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FPRO_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPRO_QUANTIDADE: Double;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_EMBALAGEM: String;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_PESOBRUTO: Double;
    FPRO_PRODUTONATABELA: String;
    FPRO_PRECOTABELA: Double;
    FPRO_APLICACAO: String;
    FSGM_CODIGO: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FPRO_ESTOQUEMINIMO: Double;
    FPRO_ESTOQUEMAXIMO: Double;
    FETQ_ESTOQUEFILIAL: Double;
    FPRO_VALORCUSTOCOMPRA: Double;
    FETQ_QUANTIDADEVENDIDA: Double;
    FETQ_VALORULTIMAVENDA: Double;
    FETQ_DATAULTIMAVENDA: TDateTime;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FPRO_QUANTIDADEUNCAIXA: Double;
  public 
    { Public declarations } 
     const Table      = 'PDA_ListaProdutos';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_QUANTIDADE', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADE: Double read FPRO_QUANTIDADE write FPRO_QUANTIDADE;
    const PRO_QUANTIDADE_Name = 'PRO_QUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('PRO_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PRO_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PESOBRUTO: Double read FPRO_PESOBRUTO write FPRO_PESOBRUTO;
    const PRO_PESOBRUTO_Name = 'PRO_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTONATABELA', ftString, 3)]
    [Dictionary('PRO_PRODUTONATABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTONATABELA: String read FPRO_PRODUTONATABELA write FPRO_PRODUTONATABELA;
    const PRO_PRODUTONATABELA_Name = 'PRO_PRODUTONATABELA';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOTABELA', ftBCD)]
    [Dictionary('PRO_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOTABELA: Double read FPRO_PRECOTABELA write FPRO_PRECOTABELA;
    const PRO_PRECOTABELA_Name = 'PRO_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PRO_APLICACAO', ftString, 300)]
    [Dictionary('PRO_APLICACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_APLICACAO: String read FPRO_APLICACAO write FPRO_APLICACAO;
    const PRO_APLICACAO_Name = 'PRO_APLICACAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

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
    [Column('PRO_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMINIMO: Double read FPRO_ESTOQUEMINIMO write FPRO_ESTOQUEMINIMO;
    const PRO_ESTOQUEMINIMO_Name = 'PRO_ESTOQUEMINIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMAXIMO: Double read FPRO_ESTOQUEMAXIMO write FPRO_ESTOQUEMAXIMO;
    const PRO_ESTOQUEMAXIMO_Name = 'PRO_ESTOQUEMAXIMO';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;
    const ETQ_ESTOQUEFILIAL_Name = 'ETQ_ESTOQUEFILIAL';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORCUSTOCOMPRA: Double read FPRO_VALORCUSTOCOMPRA write FPRO_VALORCUSTOCOMPRA;
    const PRO_VALORCUSTOCOMPRA_Name = 'PRO_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDIDA', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDIDA: Double read FETQ_QUANTIDADEVENDIDA write FETQ_QUANTIDADEVENDIDA;
    const ETQ_QUANTIDADEVENDIDA_Name = 'ETQ_QUANTIDADEVENDIDA';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORULTIMAVENDA', ftBCD)]
    [Dictionary('ETQ_VALORULTIMAVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORULTIMAVENDA: Double read FETQ_VALORULTIMAVENDA write FETQ_VALORULTIMAVENDA;
    const ETQ_VALORULTIMAVENDA_Name = 'ETQ_VALORULTIMAVENDA';

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMAVENDA', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMAVENDA', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMAVENDA: TDateTime read FETQ_DATAULTIMAVENDA write FETQ_DATAULTIMAVENDA;
    const ETQ_DATAULTIMAVENDA_Name = 'ETQ_DATAULTIMAVENDA';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MAR_NOME', ftString, 30)]
    [Dictionary('MAR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOME: String read FMAR_NOME write FMAR_NOME;
    const MAR_NOME_Name = 'MAR_NOME';

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

    [Restrictions([NoValidate])]
    [Column('PRO_QUANTIDADEUNCAIXA', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADEUNCAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADEUNCAIXA: Double read FPRO_QUANTIDADEUNCAIXA write FPRO_QUANTIDADEUNCAIXA;
    const PRO_QUANTIDADEUNCAIXA_Name = 'PRO_QUANTIDADEUNCAIXA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_ListaProdutos)

end.
