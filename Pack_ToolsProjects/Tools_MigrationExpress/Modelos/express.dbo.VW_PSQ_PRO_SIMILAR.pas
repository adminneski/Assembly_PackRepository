unit express.dbo.VW_PSQ_PRO_SIMILAR;

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
  [Table('VW_PSQ_PRO_SIMILAR', '')]
  TDtoVW_PSQ_PRO_SIMILAR = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_EMBALAGEM: String;
    FPRO_DESATIVADO: String;
    FPRO_PRODUTOFINAL: String;
    FPRO_PRODUTOIMOBILIZADO: String;
    FPRO_PRODUTOMATERIAPRIMA: String;
    FPRO_PRODUTOPECAPRONTA: String;
    FPRO_PRODUTOCONSUMO: String;
    FSGM_CODIGO: String;
    FNCM_CODIGO: Integer;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FCLF_CODIGO: String;
    FPRO_CODIGOBARRA1: String;
    FPRO_CODIGOBARRA2: String;
    FPRO_CODIGOBARRA3: String;
    FPRO_CODIGOBARRACAIXA: String;
    FPRO_QTDUNCAIXACODIGOBARRA: Double;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_CODIGOSIMILAR: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PRO_SIMILAR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 401)]
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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOCONSUMO', ftString, 1)]
    [Dictionary('PRO_PRODUTOCONSUMO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTOCONSUMO: String read FPRO_PRODUTOCONSUMO write FPRO_PRODUTOCONSUMO;
    const PRO_PRODUTOCONSUMO_Name = 'PRO_PRODUTOCONSUMO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

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
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

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
    [Column('PRO_CODIGOBARRACAIXA', ftString, 14)]
    [Dictionary('PRO_CODIGOBARRACAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRACAIXA: String read FPRO_CODIGOBARRACAIXA write FPRO_CODIGOBARRACAIXA;
    const PRO_CODIGOBARRACAIXA_Name = 'PRO_CODIGOBARRACAIXA';

    [Restrictions([NoValidate])]
    [Column('PRO_QTDUNCAIXACODIGOBARRA', ftBCD)]
    [Dictionary('PRO_QTDUNCAIXACODIGOBARRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDUNCAIXACODIGOBARRA: Double read FPRO_QTDUNCAIXACODIGOBARRA write FPRO_QTDUNCAIXACODIGOBARRA;
    const PRO_QTDUNCAIXACODIGOBARRA_Name = 'PRO_QTDUNCAIXACODIGOBARRA';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOSIMILAR', ftString, 20)]
    [Dictionary('PRO_CODIGOSIMILAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOSIMILAR: String read FPRO_CODIGOSIMILAR write FPRO_CODIGOSIMILAR;
    const PRO_CODIGOSIMILAR_Name = 'PRO_CODIGOSIMILAR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PRO_SIMILAR)

end.
