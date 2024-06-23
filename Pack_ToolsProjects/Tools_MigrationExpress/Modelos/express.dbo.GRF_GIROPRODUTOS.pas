unit express.dbo.GRF_GIROPRODUTOS;

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
  [Table('GRF_GIROPRODUTOS', '')]
  TDtoGRF_GIROPRODUTOS = class
  private
    { Private declarations } 
    FETQ_FILIAL: Integer;
    FPRO_CODIGO: Integer;
    FSGM_CODIGO: String;
    FPRO_DESCRICAO: String;
    FFAB_CODIGO: Integer;
    FPES_NOMEFABRICANTE: String;
    FETQ_ESTOQUEFILIAL: Double;
    FETQ_VALORCUSTOCOMPRA: Double;
    FETQ_QUANTIDADECOMPRADA: Double;
    FETQ_DATAULTIMACOMPRA: TDateTime;
    FPRO_ULTIMANFENTRADA: String;
    FPRO_ULTIMOFORNECEDOR: String;
    FPES_NOMEULTIMOFORNECEDOR: String;
    FPRO_PRECOTABELA: Double;
    FPRO_ESTOQUEMAXIMO: Double;
    FPRO_ESTOQUEMINIMO: Double;
    FETQ_ANOGIRO: Integer;
    FETQ_GIROJANEIRO: Double;
    FETQ_CUSTOCOMPRAJANEIRO: Double;
    FETQ_PRECOTABELAJANEIRO: Double;
    FETQ_PRECODIGITADOJANEIRO: Double;
    FETQ_QUANTIDADEVENDASJANEIRO: Double;
    FETQ_GIROFEVEREIRO: Double;
    FETQ_CUSTOCOMPRAFEVEREIRO: Double;
    FETQ_PRECOTABELAFEVEREIRO: Double;
    FETQ_PRECODIGITADOFEVEREIRO: Double;
    FETQ_QUANTIDADEVENDASFEVEREIRO: Double;
    FETQ_GIROMARCO: Double;
    FETQ_CUSTOCOMPRAMARCO: Double;
    FETQ_PRECOTABELAMARCO: Double;
    FETQ_PRECODIGITADOMARCO: Double;
    FETQ_QUANTIDADEVENDASMARCO: Double;
    FETQ_GIROABRIL: Double;
    FETQ_CUSTOCOMPRAABRIL: Double;
    FETQ_PRECOTABELAABRIL: Double;
    FETQ_PRECODIGITADOABRIL: Double;
    FETQ_QUANTIDADEVENDASABRIL: Double;
    FETQ_GIROMAIO: Double;
    FETQ_CUSTOCOMPRAMAIO: Double;
    FETQ_PRECOTABELAMAIO: Double;
    FETQ_PRECODIGITADOMAIO: Double;
    FETQ_QUANTIDADEVENDASMAIO: Double;
    FETQ_GIROJUNHO: Double;
    FETQ_CUSTOCOMPRAJUNHO: Double;
    FETQ_PRECOTABELAJUNHO: Double;
    FETQ_PRECODIGITADOJUNHO: Double;
    FETQ_QUANTIDADEVENDASJUNHO: Double;
    FETQ_GIROJULHO: Double;
    FETQ_CUSTOCOMPRAJULHO: Double;
    FETQ_PRECOTABELAJULHO: Double;
    FETQ_PRECODIGITADOJULHO: Double;
    FETQ_QUANTIDADEVENDASJULHO: Double;
    FETQ_GIROAGOSTO: Double;
    FETQ_CUSTOCOMPRAAGOSTO: Double;
    FETQ_PRECOTABELAAGOSTO: Double;
    FETQ_PRECODIGITADOAGOSTO: Double;
    FETQ_QUANTIDADEVENDASAGOSTO: Double;
    FETQ_GIROSETEMBRO: Double;
    FETQ_CUSTOCOMPRASETEMBRO: Double;
    FETQ_PRECOTABELASETEMBRO: Double;
    FETQ_PRECODIGITADOSETEMBRO: Double;
    FETQ_QUANTIDADEVENDASSETEMBRO: Double;
    FETQ_GIROOUTUBRO: Double;
    FETQ_CUSTOCOMPRAOUTUBRO: Double;
    FETQ_PRECOTABELAOUTUBRO: Double;
    FETQ_PRECODIGITADOOUTUBRO: Double;
    FETQ_QUANTIDADEVENDASOUTUBRO: Double;
    FETQ_GIRONOVEMBRO: Double;
    FETQ_CUSTOCOMPRANOVEMBRO: Double;
    FETQ_PRECOTABELANOVEMBRO: Double;
    FETQ_PRECODIGITADONOVEMBRO: Double;
    FETQ_QUANTIDADEVENDASNOVEMBRO: Double;
    FETQ_GIRODEZEMBRO: Double;
    FETQ_CUSTOCOMPRADEZEMBRO: Double;
    FETQ_PRECOTABELADEZEMBRO: Double;
    FETQ_PRECODIGITADODEZEMBRO: Double;
    FETQ_QUANTIDADEVENDASDEZEMBRO: Double;
  public 
    { Public declarations } 
     const Table      = 'GRF_GIROPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_FILIAL', ftInteger)]
    [Dictionary('ETQ_FILIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_FILIAL: Integer read FETQ_FILIAL write FETQ_FILIAL;
    const ETQ_FILIAL_Name = 'ETQ_FILIAL';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAB_CODIGO', ftInteger)]
    [Dictionary('FAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAB_CODIGO: Integer read FFAB_CODIGO write FFAB_CODIGO;
    const FAB_CODIGO_Name = 'FAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEFABRICANTE', ftString, 100)]
    [Dictionary('PES_NOMEFABRICANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEFABRICANTE: String read FPES_NOMEFABRICANTE write FPES_NOMEFABRICANTE;
    const PES_NOMEFABRICANTE_Name = 'PES_NOMEFABRICANTE';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;
    const ETQ_ESTOQUEFILIAL_Name = 'ETQ_ESTOQUEFILIAL';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOCOMPRA: Double read FETQ_VALORCUSTOCOMPRA write FETQ_VALORCUSTOCOMPRA;
    const ETQ_VALORCUSTOCOMPRA_Name = 'ETQ_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADECOMPRADA', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADECOMPRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADECOMPRADA: Double read FETQ_QUANTIDADECOMPRADA write FETQ_QUANTIDADECOMPRADA;
    const ETQ_QUANTIDADECOMPRADA_Name = 'ETQ_QUANTIDADECOMPRADA';

    [Restrictions([NoValidate])]
    [Column('ETQ_DATAULTIMACOMPRA', ftDateTime)]
    [Dictionary('ETQ_DATAULTIMACOMPRA', 'Mensagem de validação', '', '', '', taCenter)]
    property ETQ_DATAULTIMACOMPRA: TDateTime read FETQ_DATAULTIMACOMPRA write FETQ_DATAULTIMACOMPRA;
    const ETQ_DATAULTIMACOMPRA_Name = 'ETQ_DATAULTIMACOMPRA';

    [Restrictions([NoValidate])]
    [Column('PRO_ULTIMANFENTRADA', ftString, 9)]
    [Dictionary('PRO_ULTIMANFENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_ULTIMANFENTRADA: String read FPRO_ULTIMANFENTRADA write FPRO_ULTIMANFENTRADA;
    const PRO_ULTIMANFENTRADA_Name = 'PRO_ULTIMANFENTRADA';

    [Restrictions([NoValidate])]
    [Column('PRO_ULTIMOFORNECEDOR', ftString, 6)]
    [Dictionary('PRO_ULTIMOFORNECEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_ULTIMOFORNECEDOR: String read FPRO_ULTIMOFORNECEDOR write FPRO_ULTIMOFORNECEDOR;
    const PRO_ULTIMOFORNECEDOR_Name = 'PRO_ULTIMOFORNECEDOR';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEULTIMOFORNECEDOR', ftString, 100)]
    [Dictionary('PES_NOMEULTIMOFORNECEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEULTIMOFORNECEDOR: String read FPES_NOMEULTIMOFORNECEDOR write FPES_NOMEULTIMOFORNECEDOR;
    const PES_NOMEULTIMOFORNECEDOR_Name = 'PES_NOMEULTIMOFORNECEDOR';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOTABELA', ftBCD)]
    [Dictionary('PRO_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOTABELA: Double read FPRO_PRECOTABELA write FPRO_PRECOTABELA;
    const PRO_PRECOTABELA_Name = 'PRO_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMAXIMO: Double read FPRO_ESTOQUEMAXIMO write FPRO_ESTOQUEMAXIMO;
    const PRO_ESTOQUEMAXIMO_Name = 'PRO_ESTOQUEMAXIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMINIMO: Double read FPRO_ESTOQUEMINIMO write FPRO_ESTOQUEMINIMO;
    const PRO_ESTOQUEMINIMO_Name = 'PRO_ESTOQUEMINIMO';

    [Restrictions([NoValidate])]
    [Column('ETQ_ANOGIRO', ftInteger)]
    [Dictionary('ETQ_ANOGIRO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_ANOGIRO: Integer read FETQ_ANOGIRO write FETQ_ANOGIRO;
    const ETQ_ANOGIRO_Name = 'ETQ_ANOGIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROJANEIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROJANEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROJANEIRO: Double read FETQ_GIROJANEIRO write FETQ_GIROJANEIRO;
    const ETQ_GIROJANEIRO_Name = 'ETQ_GIROJANEIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAJANEIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAJANEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAJANEIRO: Double read FETQ_CUSTOCOMPRAJANEIRO write FETQ_CUSTOCOMPRAJANEIRO;
    const ETQ_CUSTOCOMPRAJANEIRO_Name = 'ETQ_CUSTOCOMPRAJANEIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAJANEIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAJANEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAJANEIRO: Double read FETQ_PRECOTABELAJANEIRO write FETQ_PRECOTABELAJANEIRO;
    const ETQ_PRECOTABELAJANEIRO_Name = 'ETQ_PRECOTABELAJANEIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOJANEIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOJANEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOJANEIRO: Double read FETQ_PRECODIGITADOJANEIRO write FETQ_PRECODIGITADOJANEIRO;
    const ETQ_PRECODIGITADOJANEIRO_Name = 'ETQ_PRECODIGITADOJANEIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASJANEIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASJANEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASJANEIRO: Double read FETQ_QUANTIDADEVENDASJANEIRO write FETQ_QUANTIDADEVENDASJANEIRO;
    const ETQ_QUANTIDADEVENDASJANEIRO_Name = 'ETQ_QUANTIDADEVENDASJANEIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROFEVEREIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROFEVEREIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROFEVEREIRO: Double read FETQ_GIROFEVEREIRO write FETQ_GIROFEVEREIRO;
    const ETQ_GIROFEVEREIRO_Name = 'ETQ_GIROFEVEREIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAFEVEREIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAFEVEREIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAFEVEREIRO: Double read FETQ_CUSTOCOMPRAFEVEREIRO write FETQ_CUSTOCOMPRAFEVEREIRO;
    const ETQ_CUSTOCOMPRAFEVEREIRO_Name = 'ETQ_CUSTOCOMPRAFEVEREIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAFEVEREIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAFEVEREIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAFEVEREIRO: Double read FETQ_PRECOTABELAFEVEREIRO write FETQ_PRECOTABELAFEVEREIRO;
    const ETQ_PRECOTABELAFEVEREIRO_Name = 'ETQ_PRECOTABELAFEVEREIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOFEVEREIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOFEVEREIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOFEVEREIRO: Double read FETQ_PRECODIGITADOFEVEREIRO write FETQ_PRECODIGITADOFEVEREIRO;
    const ETQ_PRECODIGITADOFEVEREIRO_Name = 'ETQ_PRECODIGITADOFEVEREIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASFEVEREIRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASFEVEREIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASFEVEREIRO: Double read FETQ_QUANTIDADEVENDASFEVEREIRO write FETQ_QUANTIDADEVENDASFEVEREIRO;
    const ETQ_QUANTIDADEVENDASFEVEREIRO_Name = 'ETQ_QUANTIDADEVENDASFEVEREIRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROMARCO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROMARCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROMARCO: Double read FETQ_GIROMARCO write FETQ_GIROMARCO;
    const ETQ_GIROMARCO_Name = 'ETQ_GIROMARCO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAMARCO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAMARCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAMARCO: Double read FETQ_CUSTOCOMPRAMARCO write FETQ_CUSTOCOMPRAMARCO;
    const ETQ_CUSTOCOMPRAMARCO_Name = 'ETQ_CUSTOCOMPRAMARCO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAMARCO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAMARCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAMARCO: Double read FETQ_PRECOTABELAMARCO write FETQ_PRECOTABELAMARCO;
    const ETQ_PRECOTABELAMARCO_Name = 'ETQ_PRECOTABELAMARCO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOMARCO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOMARCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOMARCO: Double read FETQ_PRECODIGITADOMARCO write FETQ_PRECODIGITADOMARCO;
    const ETQ_PRECODIGITADOMARCO_Name = 'ETQ_PRECODIGITADOMARCO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASMARCO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASMARCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASMARCO: Double read FETQ_QUANTIDADEVENDASMARCO write FETQ_QUANTIDADEVENDASMARCO;
    const ETQ_QUANTIDADEVENDASMARCO_Name = 'ETQ_QUANTIDADEVENDASMARCO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROABRIL', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROABRIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROABRIL: Double read FETQ_GIROABRIL write FETQ_GIROABRIL;
    const ETQ_GIROABRIL_Name = 'ETQ_GIROABRIL';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAABRIL', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAABRIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAABRIL: Double read FETQ_CUSTOCOMPRAABRIL write FETQ_CUSTOCOMPRAABRIL;
    const ETQ_CUSTOCOMPRAABRIL_Name = 'ETQ_CUSTOCOMPRAABRIL';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAABRIL', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAABRIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAABRIL: Double read FETQ_PRECOTABELAABRIL write FETQ_PRECOTABELAABRIL;
    const ETQ_PRECOTABELAABRIL_Name = 'ETQ_PRECOTABELAABRIL';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOABRIL', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOABRIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOABRIL: Double read FETQ_PRECODIGITADOABRIL write FETQ_PRECODIGITADOABRIL;
    const ETQ_PRECODIGITADOABRIL_Name = 'ETQ_PRECODIGITADOABRIL';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASABRIL', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASABRIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASABRIL: Double read FETQ_QUANTIDADEVENDASABRIL write FETQ_QUANTIDADEVENDASABRIL;
    const ETQ_QUANTIDADEVENDASABRIL_Name = 'ETQ_QUANTIDADEVENDASABRIL';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROMAIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROMAIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROMAIO: Double read FETQ_GIROMAIO write FETQ_GIROMAIO;
    const ETQ_GIROMAIO_Name = 'ETQ_GIROMAIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAMAIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAMAIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAMAIO: Double read FETQ_CUSTOCOMPRAMAIO write FETQ_CUSTOCOMPRAMAIO;
    const ETQ_CUSTOCOMPRAMAIO_Name = 'ETQ_CUSTOCOMPRAMAIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAMAIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAMAIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAMAIO: Double read FETQ_PRECOTABELAMAIO write FETQ_PRECOTABELAMAIO;
    const ETQ_PRECOTABELAMAIO_Name = 'ETQ_PRECOTABELAMAIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOMAIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOMAIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOMAIO: Double read FETQ_PRECODIGITADOMAIO write FETQ_PRECODIGITADOMAIO;
    const ETQ_PRECODIGITADOMAIO_Name = 'ETQ_PRECODIGITADOMAIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASMAIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASMAIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASMAIO: Double read FETQ_QUANTIDADEVENDASMAIO write FETQ_QUANTIDADEVENDASMAIO;
    const ETQ_QUANTIDADEVENDASMAIO_Name = 'ETQ_QUANTIDADEVENDASMAIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROJUNHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROJUNHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROJUNHO: Double read FETQ_GIROJUNHO write FETQ_GIROJUNHO;
    const ETQ_GIROJUNHO_Name = 'ETQ_GIROJUNHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAJUNHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAJUNHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAJUNHO: Double read FETQ_CUSTOCOMPRAJUNHO write FETQ_CUSTOCOMPRAJUNHO;
    const ETQ_CUSTOCOMPRAJUNHO_Name = 'ETQ_CUSTOCOMPRAJUNHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAJUNHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAJUNHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAJUNHO: Double read FETQ_PRECOTABELAJUNHO write FETQ_PRECOTABELAJUNHO;
    const ETQ_PRECOTABELAJUNHO_Name = 'ETQ_PRECOTABELAJUNHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOJUNHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOJUNHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOJUNHO: Double read FETQ_PRECODIGITADOJUNHO write FETQ_PRECODIGITADOJUNHO;
    const ETQ_PRECODIGITADOJUNHO_Name = 'ETQ_PRECODIGITADOJUNHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASJUNHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASJUNHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASJUNHO: Double read FETQ_QUANTIDADEVENDASJUNHO write FETQ_QUANTIDADEVENDASJUNHO;
    const ETQ_QUANTIDADEVENDASJUNHO_Name = 'ETQ_QUANTIDADEVENDASJUNHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROJULHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROJULHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROJULHO: Double read FETQ_GIROJULHO write FETQ_GIROJULHO;
    const ETQ_GIROJULHO_Name = 'ETQ_GIROJULHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAJULHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAJULHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAJULHO: Double read FETQ_CUSTOCOMPRAJULHO write FETQ_CUSTOCOMPRAJULHO;
    const ETQ_CUSTOCOMPRAJULHO_Name = 'ETQ_CUSTOCOMPRAJULHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAJULHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAJULHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAJULHO: Double read FETQ_PRECOTABELAJULHO write FETQ_PRECOTABELAJULHO;
    const ETQ_PRECOTABELAJULHO_Name = 'ETQ_PRECOTABELAJULHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOJULHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOJULHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOJULHO: Double read FETQ_PRECODIGITADOJULHO write FETQ_PRECODIGITADOJULHO;
    const ETQ_PRECODIGITADOJULHO_Name = 'ETQ_PRECODIGITADOJULHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASJULHO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASJULHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASJULHO: Double read FETQ_QUANTIDADEVENDASJULHO write FETQ_QUANTIDADEVENDASJULHO;
    const ETQ_QUANTIDADEVENDASJULHO_Name = 'ETQ_QUANTIDADEVENDASJULHO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROAGOSTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROAGOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROAGOSTO: Double read FETQ_GIROAGOSTO write FETQ_GIROAGOSTO;
    const ETQ_GIROAGOSTO_Name = 'ETQ_GIROAGOSTO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAAGOSTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAAGOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAAGOSTO: Double read FETQ_CUSTOCOMPRAAGOSTO write FETQ_CUSTOCOMPRAAGOSTO;
    const ETQ_CUSTOCOMPRAAGOSTO_Name = 'ETQ_CUSTOCOMPRAAGOSTO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAAGOSTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAAGOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAAGOSTO: Double read FETQ_PRECOTABELAAGOSTO write FETQ_PRECOTABELAAGOSTO;
    const ETQ_PRECOTABELAAGOSTO_Name = 'ETQ_PRECOTABELAAGOSTO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOAGOSTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOAGOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOAGOSTO: Double read FETQ_PRECODIGITADOAGOSTO write FETQ_PRECODIGITADOAGOSTO;
    const ETQ_PRECODIGITADOAGOSTO_Name = 'ETQ_PRECODIGITADOAGOSTO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASAGOSTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASAGOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASAGOSTO: Double read FETQ_QUANTIDADEVENDASAGOSTO write FETQ_QUANTIDADEVENDASAGOSTO;
    const ETQ_QUANTIDADEVENDASAGOSTO_Name = 'ETQ_QUANTIDADEVENDASAGOSTO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROSETEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROSETEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROSETEMBRO: Double read FETQ_GIROSETEMBRO write FETQ_GIROSETEMBRO;
    const ETQ_GIROSETEMBRO_Name = 'ETQ_GIROSETEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRASETEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRASETEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRASETEMBRO: Double read FETQ_CUSTOCOMPRASETEMBRO write FETQ_CUSTOCOMPRASETEMBRO;
    const ETQ_CUSTOCOMPRASETEMBRO_Name = 'ETQ_CUSTOCOMPRASETEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELASETEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELASETEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELASETEMBRO: Double read FETQ_PRECOTABELASETEMBRO write FETQ_PRECOTABELASETEMBRO;
    const ETQ_PRECOTABELASETEMBRO_Name = 'ETQ_PRECOTABELASETEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOSETEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOSETEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOSETEMBRO: Double read FETQ_PRECODIGITADOSETEMBRO write FETQ_PRECODIGITADOSETEMBRO;
    const ETQ_PRECODIGITADOSETEMBRO_Name = 'ETQ_PRECODIGITADOSETEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASSETEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASSETEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASSETEMBRO: Double read FETQ_QUANTIDADEVENDASSETEMBRO write FETQ_QUANTIDADEVENDASSETEMBRO;
    const ETQ_QUANTIDADEVENDASSETEMBRO_Name = 'ETQ_QUANTIDADEVENDASSETEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIROOUTUBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIROOUTUBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIROOUTUBRO: Double read FETQ_GIROOUTUBRO write FETQ_GIROOUTUBRO;
    const ETQ_GIROOUTUBRO_Name = 'ETQ_GIROOUTUBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRAOUTUBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRAOUTUBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRAOUTUBRO: Double read FETQ_CUSTOCOMPRAOUTUBRO write FETQ_CUSTOCOMPRAOUTUBRO;
    const ETQ_CUSTOCOMPRAOUTUBRO_Name = 'ETQ_CUSTOCOMPRAOUTUBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELAOUTUBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELAOUTUBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELAOUTUBRO: Double read FETQ_PRECOTABELAOUTUBRO write FETQ_PRECOTABELAOUTUBRO;
    const ETQ_PRECOTABELAOUTUBRO_Name = 'ETQ_PRECOTABELAOUTUBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADOOUTUBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADOOUTUBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADOOUTUBRO: Double read FETQ_PRECODIGITADOOUTUBRO write FETQ_PRECODIGITADOOUTUBRO;
    const ETQ_PRECODIGITADOOUTUBRO_Name = 'ETQ_PRECODIGITADOOUTUBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASOUTUBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASOUTUBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASOUTUBRO: Double read FETQ_QUANTIDADEVENDASOUTUBRO write FETQ_QUANTIDADEVENDASOUTUBRO;
    const ETQ_QUANTIDADEVENDASOUTUBRO_Name = 'ETQ_QUANTIDADEVENDASOUTUBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIRONOVEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIRONOVEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIRONOVEMBRO: Double read FETQ_GIRONOVEMBRO write FETQ_GIRONOVEMBRO;
    const ETQ_GIRONOVEMBRO_Name = 'ETQ_GIRONOVEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRANOVEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRANOVEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRANOVEMBRO: Double read FETQ_CUSTOCOMPRANOVEMBRO write FETQ_CUSTOCOMPRANOVEMBRO;
    const ETQ_CUSTOCOMPRANOVEMBRO_Name = 'ETQ_CUSTOCOMPRANOVEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELANOVEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELANOVEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELANOVEMBRO: Double read FETQ_PRECOTABELANOVEMBRO write FETQ_PRECOTABELANOVEMBRO;
    const ETQ_PRECOTABELANOVEMBRO_Name = 'ETQ_PRECOTABELANOVEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADONOVEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADONOVEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADONOVEMBRO: Double read FETQ_PRECODIGITADONOVEMBRO write FETQ_PRECODIGITADONOVEMBRO;
    const ETQ_PRECODIGITADONOVEMBRO_Name = 'ETQ_PRECODIGITADONOVEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASNOVEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASNOVEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASNOVEMBRO: Double read FETQ_QUANTIDADEVENDASNOVEMBRO write FETQ_QUANTIDADEVENDASNOVEMBRO;
    const ETQ_QUANTIDADEVENDASNOVEMBRO_Name = 'ETQ_QUANTIDADEVENDASNOVEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_GIRODEZEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_GIRODEZEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_GIRODEZEMBRO: Double read FETQ_GIRODEZEMBRO write FETQ_GIRODEZEMBRO;
    const ETQ_GIRODEZEMBRO_Name = 'ETQ_GIRODEZEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_CUSTOCOMPRADEZEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_CUSTOCOMPRADEZEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_CUSTOCOMPRADEZEMBRO: Double read FETQ_CUSTOCOMPRADEZEMBRO write FETQ_CUSTOCOMPRADEZEMBRO;
    const ETQ_CUSTOCOMPRADEZEMBRO_Name = 'ETQ_CUSTOCOMPRADEZEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECOTABELADEZEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECOTABELADEZEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECOTABELADEZEMBRO: Double read FETQ_PRECOTABELADEZEMBRO write FETQ_PRECOTABELADEZEMBRO;
    const ETQ_PRECOTABELADEZEMBRO_Name = 'ETQ_PRECOTABELADEZEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_PRECODIGITADODEZEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_PRECODIGITADODEZEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_PRECODIGITADODEZEMBRO: Double read FETQ_PRECODIGITADODEZEMBRO write FETQ_PRECODIGITADODEZEMBRO;
    const ETQ_PRECODIGITADODEZEMBRO_Name = 'ETQ_PRECODIGITADODEZEMBRO';

    [Restrictions([NoValidate])]
    [Column('ETQ_QUANTIDADEVENDASDEZEMBRO', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDASDEZEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDASDEZEMBRO: Double read FETQ_QUANTIDADEVENDASDEZEMBRO write FETQ_QUANTIDADEVENDASDEZEMBRO;
    const ETQ_QUANTIDADEVENDASDEZEMBRO_Name = 'ETQ_QUANTIDADEVENDASDEZEMBRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGRF_GIROPRODUTOS)

end.
