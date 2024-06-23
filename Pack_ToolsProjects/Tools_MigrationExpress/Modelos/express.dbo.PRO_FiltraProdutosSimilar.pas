unit express.dbo.PRO_FILTRAPRODUTOSSIMILAR;

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
  [Table('PRO_FiltraProdutosSimilar', '')]
  TDtoPRO_FiltraProdutosSimilar = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_EMBALAGEM: String;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_APLICACAO: String;
    FSGM_CODIGO: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FCOM_CODIGO: Integer;
    FETQ_ESTOQUEFILIAL: Double;
    FETQ_VALORCUSTOPRODUTO: Double;
    FTAB_CODIGO: Integer;
    FTAB_DESCRICAO: String;
    FPRO_PRECOPEDIDO: Double;
    FPRO_CODIGOBARRA: String;
    FPRO_PRODUTOFINAL: String;
    FPRO_PRODUTOCONSUMO: String;
    FPRO_PRODUTOIMOBILIZADO: String;
    FPRO_PRODUTOPECAPRONTA: String;
    FPRO_PRODUTOMATERIAPRIMA: String;
    FMAR_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FMAR_NOME: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FLCZ_ETIQUETALOCALIZACAO: String;
    FETQ_RESERVA: Double;
    FPRO_CODIGOSIMILAR: String;
    FPRO_OBSERVACAO: String;
    FPRO_VALORCUSTOMERCADO: Double;
  public 
    { Public declarations } 
     const Table      = 'PRO_FiltraProdutosSimilar';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;
    const ETQ_ESTOQUEFILIAL_Name = 'ETQ_ESTOQUEFILIAL';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOPRODUTO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOPRODUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOPRODUTO: Double read FETQ_VALORCUSTOPRODUTO write FETQ_VALORCUSTOPRODUTO;
    const ETQ_VALORCUSTOPRODUTO_Name = 'ETQ_VALORCUSTOPRODUTO';

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

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA: String read FPRO_CODIGOBARRA write FPRO_CODIGOBARRA;
    const PRO_CODIGOBARRA_Name = 'PRO_CODIGOBARRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOFINAL', ftString, 1)]
    [Dictionary('PRO_PRODUTOFINAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOFINAL: String read FPRO_PRODUTOFINAL write FPRO_PRODUTOFINAL;
    const PRO_PRODUTOFINAL_Name = 'PRO_PRODUTOFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOCONSUMO', ftString, 1)]
    [Dictionary('PRO_PRODUTOCONSUMO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOCONSUMO: String read FPRO_PRODUTOCONSUMO write FPRO_PRODUTOCONSUMO;
    const PRO_PRODUTOCONSUMO_Name = 'PRO_PRODUTOCONSUMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOIMOBILIZADO', ftString, 1)]
    [Dictionary('PRO_PRODUTOIMOBILIZADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOIMOBILIZADO: String read FPRO_PRODUTOIMOBILIZADO write FPRO_PRODUTOIMOBILIZADO;
    const PRO_PRODUTOIMOBILIZADO_Name = 'PRO_PRODUTOIMOBILIZADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOPECAPRONTA', ftString, 1)]
    [Dictionary('PRO_PRODUTOPECAPRONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOPECAPRONTA: String read FPRO_PRODUTOPECAPRONTA write FPRO_PRODUTOPECAPRONTA;
    const PRO_PRODUTOPECAPRONTA_Name = 'PRO_PRODUTOPECAPRONTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOMATERIAPRIMA', ftString, 1)]
    [Dictionary('PRO_PRODUTOMATERIAPRIMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOMATERIAPRIMA: String read FPRO_PRODUTOMATERIAPRIMA write FPRO_PRODUTOMATERIAPRIMA;
    const PRO_PRODUTOMATERIAPRIMA_Name = 'PRO_PRODUTOMATERIAPRIMA';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('MAR_NOME', ftString, 30)]
    [Dictionary('MAR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOME: String read FMAR_NOME write FMAR_NOME;
    const MAR_NOME_Name = 'MAR_NOME';

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
    [Column('LCZ_ETIQUETALOCALIZACAO', ftString, 10)]
    [Dictionary('LCZ_ETIQUETALOCALIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_ETIQUETALOCALIZACAO: String read FLCZ_ETIQUETALOCALIZACAO write FLCZ_ETIQUETALOCALIZACAO;
    const LCZ_ETIQUETALOCALIZACAO_Name = 'LCZ_ETIQUETALOCALIZACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_RESERVA', ftBCD)]
    [Dictionary('ETQ_RESERVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_RESERVA: Double read FETQ_RESERVA write FETQ_RESERVA;
    const ETQ_RESERVA_Name = 'ETQ_RESERVA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOSIMILAR', ftString, 20)]
    [Dictionary('PRO_CODIGOSIMILAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOSIMILAR: String read FPRO_CODIGOSIMILAR write FPRO_CODIGOSIMILAR;
    const PRO_CODIGOSIMILAR_Name = 'PRO_CODIGOSIMILAR';

    [Restrictions([NoValidate])]
    [Column('PRO_OBSERVACAO', ftString, 300)]
    [Dictionary('PRO_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_OBSERVACAO: String read FPRO_OBSERVACAO write FPRO_OBSERVACAO;
    const PRO_OBSERVACAO_Name = 'PRO_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORCUSTOMERCADO', ftBCD)]
    [Dictionary('PRO_VALORCUSTOMERCADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORCUSTOMERCADO: Double read FPRO_VALORCUSTOMERCADO write FPRO_VALORCUSTOMERCADO;
    const PRO_VALORCUSTOMERCADO_Name = 'PRO_VALORCUSTOMERCADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_FiltraProdutosSimilar)

end.
