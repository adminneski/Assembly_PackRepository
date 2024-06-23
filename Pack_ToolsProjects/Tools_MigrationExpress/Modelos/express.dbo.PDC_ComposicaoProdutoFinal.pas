unit express.dbo.PDC_COMPOSICAOPRODUTOFINAL;

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
  [Table('PDC_ComposicaoProdutoFinal', '')]
  TDtoPDC_ComposicaoProdutoFinal = class
  private
    { Private declarations } 
    FPDC_ID: Integer;
    FPDC_02_ID: Integer;
    FPDC_02_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRM_CODIGO: Integer;
    FPRM_DESCRICAO: String;
    FPRM_QTDCOMPOSICAO: Double;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_REFERENCIAINTERNA: String;
    FSGM_CODIGO: String;
    FSGM_SIGLA: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FPRO_QUANTIDADEUNCAIXA: Double;
  public 
    { Public declarations } 
     const Table      = 'PDC_ComposicaoProdutoFinal';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_ID', ftInteger)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_02_ID', ftInteger)]
    [Dictionary('PDC_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_ID: Integer read FPDC_02_ID write FPDC_02_ID;
    const PDC_02_ID_Name = 'PDC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_02_01_ID', ftInteger)]
    [Dictionary('PDC_02_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_01_ID: Integer read FPDC_02_01_ID write FPDC_02_01_ID;
    const PDC_02_01_ID_Name = 'PDC_02_01_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRM_QTDCOMPOSICAO', ftBCD, 18, 4)]
    [Dictionary('PRM_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRM_QTDCOMPOSICAO: Double read FPRM_QTDCOMPOSICAO write FPRM_QTDCOMPOSICAO;
    const PRM_QTDCOMPOSICAO_Name = 'PRM_QTDCOMPOSICAO';

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
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

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
  TRegisterClass.RegisterEntity(TDtoPDC_ComposicaoProdutoFinal)

end.
