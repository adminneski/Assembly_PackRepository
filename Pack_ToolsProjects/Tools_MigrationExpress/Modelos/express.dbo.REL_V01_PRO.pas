unit express.dbo.REL_V01_PRO;

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
  [Table('REL_V01_PRO', '')]
  TDtoREL_V01_PRO = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FGRP_CODIGO: Integer;
    FSGP_CODIGO: Integer;
    FSGM_CODIGO: String;
    FPRO_EMBALAGEM: String;
    FPRO_DESATIVADO: String;
    FPRO_PRODUTOFINAL: String;
    FPRO_PRODUTOCONSUMO: String;
    FPRO_PRODUTOIMOBILIZADO: String;
    FPRO_PRODUTOMATERIAPRIMA: String;
    FPRO_PRODUTOPECAPRONTA: String;
    FCOM_CODIGO: Integer;
    FETQ_ESTOQUEFILIAL: Double;
    FETQ_ESTOQUEFILIALPRODUCAO: Double;
    FPRO_ESTOQUEMAXIMO: Double;
    FPRO_ESTOQUEMINIMO: Double;
    FGRP_GRUPO: String;
    FGRP_DESCRICAO: String;
    FGRP_NOMEAPELIDO: String;
    FSGP_SUBGRUPO: String;
    FSGP_DESCRICAO: String;
    FSGP_NOMEAPELIDO: String;
    FSGM_SIGLA: String;
    FLCZ_CODIGO: Integer;
    FLCZ_ETIQUETALOCALIZACAO: String;
    FETQ_VALORCUSTOCOMPRAMEDIO: Double;
    FETQ_VALORCUSTOLIQUIDOMEDIO: Double;
    FETQ_VALORCUSTOINVENTARIOMEDIO: Double;
    FETQ_VALORULTIMAVENDA: Double;
    FETQ_DATAULTIMAVENDA: TDateTime;
    FETQ_QUANTIDADEVENDIDA: Double;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FPRO_REFERENCIAINTERNA: String;
    FETQ_ESTOQUEMAXIMO: Double;
    FETQ_ESTOQUEMINIMO: Double;
    FFOR_CODIGO: Integer;
    FFOR_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_PRO';

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
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESATIVADO', ftString, 1)]
    [Dictionary('PRO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESATIVADO: String read FPRO_DESATIVADO write FPRO_DESATIVADO;
    const PRO_DESATIVADO_Name = 'PRO_DESATIVADO';

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
    [Column('PRO_PRODUTOMATERIAPRIMA', ftString, 1)]
    [Dictionary('PRO_PRODUTOMATERIAPRIMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOMATERIAPRIMA: String read FPRO_PRODUTOMATERIAPRIMA write FPRO_PRODUTOMATERIAPRIMA;
    const PRO_PRODUTOMATERIAPRIMA_Name = 'PRO_PRODUTOMATERIAPRIMA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOPECAPRONTA', ftString, 1)]
    [Dictionary('PRO_PRODUTOPECAPRONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOPECAPRONTA: String read FPRO_PRODUTOPECAPRONTA write FPRO_PRODUTOPECAPRONTA;
    const PRO_PRODUTOPECAPRONTA_Name = 'PRO_PRODUTOPECAPRONTA';

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
    [Column('ETQ_ESTOQUEFILIALPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIALPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIALPRODUCAO: Double read FETQ_ESTOQUEFILIALPRODUCAO write FETQ_ESTOQUEFILIALPRODUCAO;
    const ETQ_ESTOQUEFILIALPRODUCAO_Name = 'ETQ_ESTOQUEFILIALPRODUCAO';

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
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRP_NOMEAPELIDO', ftString, 10)]
    [Dictionary('GRP_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_NOMEAPELIDO: String read FGRP_NOMEAPELIDO write FGRP_NOMEAPELIDO;
    const GRP_NOMEAPELIDO_Name = 'GRP_NOMEAPELIDO';

    [Restrictions([NoValidate])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_NOMEAPELIDO', ftString, 10)]
    [Dictionary('SGP_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_NOMEAPELIDO: String read FSGP_NOMEAPELIDO write FSGP_NOMEAPELIDO;
    const SGP_NOMEAPELIDO_Name = 'SGP_NOMEAPELIDO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_ETIQUETALOCALIZACAO', ftString, 10)]
    [Dictionary('LCZ_ETIQUETALOCALIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_ETIQUETALOCALIZACAO: String read FLCZ_ETIQUETALOCALIZACAO write FLCZ_ETIQUETALOCALIZACAO;
    const LCZ_ETIQUETALOCALIZACAO_Name = 'LCZ_ETIQUETALOCALIZACAO';

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
    [Column('ETQ_QUANTIDADEVENDIDA', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVENDIDA: Double read FETQ_QUANTIDADEVENDIDA write FETQ_QUANTIDADEVENDIDA;
    const ETQ_QUANTIDADEVENDIDA_Name = 'ETQ_QUANTIDADEVENDIDA';

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
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEMAXIMO: Double read FETQ_ESTOQUEMAXIMO write FETQ_ESTOQUEMAXIMO;
    const ETQ_ESTOQUEMAXIMO_Name = 'ETQ_ESTOQUEMAXIMO';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEMINIMO: Double read FETQ_ESTOQUEMINIMO write FETQ_ESTOQUEMINIMO;
    const ETQ_ESTOQUEMINIMO_Name = 'ETQ_ESTOQUEMINIMO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_NOME', ftString, 100)]
    [Dictionary('FOR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_NOME: String read FFOR_NOME write FFOR_NOME;
    const FOR_NOME_Name = 'FOR_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_PRO)

end.
