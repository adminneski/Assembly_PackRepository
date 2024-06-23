unit express.dbo.PRO_00;

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
  [Table('PRO_00', '')]
  [PrimaryKey('PRO_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_CODIGO')]
  TDtoPRO_00 = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_NOMEAPELIDO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FGRP_CODIGO: Integer;
    FSGP_CODIGO: Integer;
    FSGM_CODIGO: String;
    FCLF_CODIGO: String;
    FNCM_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FFAB_CODIGO: Integer;
    FMAR_CODIGO: Integer;
    FPRO_APLICACAO: String;
    FPRO_DATACADASTRO: TDateTime;
    FPRO_NUMEROVOLUMES: Double;
    FPRO_QUANTIDADEUNCAIXA: Double;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_CFNBM: String;
    FPRO_EMBALAGEM: String;
    FPRO_PESOBRUTO: Double;
    FPRO_PESOLIQUIDO: Double;
    FPRO_PARAMETROS: String;
    FPRO_PROCEDENCIA: String;
    FPRO_PERCENTUALRCFDC: Double;
    FPRO_PERCENTUALLUCROMKP: Double;
    FPRO_PERCENTUALCOMISSAO: Double;
    FPRO_PRODUTOFINAL: String;
    FPRO_PRODUTOCONSUMO: String;
    FPRO_PRODUTOIMOBILIZADO: String;
    FPRO_PRODUTOPECAPRONTA: String;
    FPRO_PRODUTOMATERIAPRIMA: String;
    FPRO_VALIDADEBALANCA: Integer;
    FPRO_PERIODOGARANTIA: String;
    FPRO_QTDADEMINIMAATACADO: Double;
    FPRO_PERCENTUALDESCTOATACADO: Double;
    FPRO_CODIGOANP: String;
    FPRO_CEST: String;
    FPRO_VALORCUSTOMERCADO: Double;
    FPRO_DESCRICAOANP: String;
    FPRO_PERCENTUALGASGLP: Double;
    FPRO_PERCENTUALGASGNN: Double;
    FPRO_PERCENTUALGASGNI: Double;
    FPRO_QTDMETROCUBICO: Double;
    FPRO_CODIGOBARRA1: String;
    FPRO_CODIGOBARRA2: String;
    FPRO_CODIGOBARRA3: String;
    FPRO_CODIGOBARRACAIXA: String;
    FPRO_QTDUNCAIXACODIGOBARRA: Double;
    FPRO_OBSERVACAO: String;
    FPRO_DESATIVADO: String;
    FPRO_DATAALTERACAO: TDateTime;
    FSGM_CODIGOTRIBUTAVEL: String;
    FPRO_QUANTIDADETRIBUTAVEL: Double;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRO_00';
     const PrimaryKey = 'PRO_CODIGO';
     const Sequence   = 'SEQ_PRO_CODIGO';

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
    [Column('PRO_NOMEAPELIDO', ftString, 30)]
    [Dictionary('PRO_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOMEAPELIDO: String read FPRO_NOMEAPELIDO write FPRO_NOMEAPELIDO;
    const PRO_NOMEAPELIDO_Name = 'PRO_NOMEAPELIDO';

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
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_CODIGO', ftInteger)]
    [Dictionary('FAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAB_CODIGO: Integer read FFAB_CODIGO write FFAB_CODIGO;
    const FAB_CODIGO_Name = 'FAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_APLICACAO', ftString, 300)]
    [Dictionary('PRO_APLICACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_APLICACAO: String read FPRO_APLICACAO write FPRO_APLICACAO;
    const PRO_APLICACAO_Name = 'PRO_APLICACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATACADASTRO', ftDateTime)]
    [Dictionary('PRO_DATACADASTRO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATACADASTRO: TDateTime read FPRO_DATACADASTRO write FPRO_DATACADASTRO;
    const PRO_DATACADASTRO_Name = 'PRO_DATACADASTRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_NUMEROVOLUMES', ftBCD, 1769238085, 2)]
    [Dictionary('PRO_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_NUMEROVOLUMES: Double read FPRO_NUMEROVOLUMES write FPRO_NUMEROVOLUMES;
    const PRO_NUMEROVOLUMES_Name = 'PRO_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_QUANTIDADEUNCAIXA', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADEUNCAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADEUNCAIXA: Double read FPRO_QUANTIDADEUNCAIXA write FPRO_QUANTIDADEUNCAIXA;
    const PRO_QUANTIDADEUNCAIXA_Name = 'PRO_QUANTIDADEUNCAIXA';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('PRO_CFNBM', ftString, 11)]
    [Dictionary('PRO_CFNBM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CFNBM: String read FPRO_CFNBM write FPRO_CFNBM;
    const PRO_CFNBM_Name = 'PRO_CFNBM';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PRO_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PESOBRUTO: Double read FPRO_PESOBRUTO write FPRO_PESOBRUTO;
    const PRO_PESOBRUTO_Name = 'PRO_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PRO_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PESOLIQUIDO: Double read FPRO_PESOLIQUIDO write FPRO_PESOLIQUIDO;
    const PRO_PESOLIQUIDO_Name = 'PRO_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PRO_PARAMETROS', ftString, 10)]
    [Dictionary('PRO_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PARAMETROS: String read FPRO_PARAMETROS write FPRO_PARAMETROS;
    const PRO_PARAMETROS_Name = 'PRO_PARAMETROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PROCEDENCIA', ftString, 1)]
    [Dictionary('PRO_PROCEDENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PROCEDENCIA: String read FPRO_PROCEDENCIA write FPRO_PROCEDENCIA;
    const PRO_PROCEDENCIA_Name = 'PRO_PROCEDENCIA';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALRCFDC', ftBCD, 18, 4)]
    [Dictionary('PRO_PERCENTUALRCFDC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALRCFDC: Double read FPRO_PERCENTUALRCFDC write FPRO_PERCENTUALRCFDC;
    const PRO_PERCENTUALRCFDC_Name = 'PRO_PERCENTUALRCFDC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PERCENTUALLUCROMKP', ftBCD, 656419879, 2)]
    [Dictionary('PRO_PERCENTUALLUCROMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALLUCROMKP: Double read FPRO_PERCENTUALLUCROMKP write FPRO_PERCENTUALLUCROMKP;
    const PRO_PERCENTUALLUCROMKP_Name = 'PRO_PERCENTUALLUCROMKP';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALCOMISSAO', ftBCD, 6881394, 2)]
    [Dictionary('PRO_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALCOMISSAO: Double read FPRO_PERCENTUALCOMISSAO write FPRO_PERCENTUALCOMISSAO;
    const PRO_PERCENTUALCOMISSAO_Name = 'PRO_PERCENTUALCOMISSAO';

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
    [Column('PRO_VALIDADEBALANCA', ftInteger)]
    [Dictionary('PRO_VALIDADEBALANCA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_VALIDADEBALANCA: Integer read FPRO_VALIDADEBALANCA write FPRO_VALIDADEBALANCA;
    const PRO_VALIDADEBALANCA_Name = 'PRO_VALIDADEBALANCA';

    [Restrictions([NoValidate])]
    [Column('PRO_PERIODOGARANTIA', ftString, 2)]
    [Dictionary('PRO_PERIODOGARANTIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PERIODOGARANTIA: String read FPRO_PERIODOGARANTIA write FPRO_PERIODOGARANTIA;
    const PRO_PERIODOGARANTIA_Name = 'PRO_PERIODOGARANTIA';

    [Restrictions([NoValidate])]
    [Column('PRO_QTDADEMINIMAATACADO', ftBCD, 544040295, 3)]
    [Dictionary('PRO_QTDADEMINIMAATACADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDADEMINIMAATACADO: Double read FPRO_QTDADEMINIMAATACADO write FPRO_QTDADEMINIMAATACADO;
    const PRO_QTDADEMINIMAATACADO_Name = 'PRO_QTDADEMINIMAATACADO';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALDESCTOATACADO', ftBCD, 1195983951, 2)]
    [Dictionary('PRO_PERCENTUALDESCTOATACADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALDESCTOATACADO: Double read FPRO_PERCENTUALDESCTOATACADO write FPRO_PERCENTUALDESCTOATACADO;
    const PRO_PERCENTUALDESCTOATACADO_Name = 'PRO_PERCENTUALDESCTOATACADO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOANP', ftString, 9)]
    [Dictionary('PRO_CODIGOANP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOANP: String read FPRO_CODIGOANP write FPRO_CODIGOANP;
    const PRO_CODIGOANP_Name = 'PRO_CODIGOANP';

    [Restrictions([NoValidate])]
    [Column('PRO_CEST', ftString, 7)]
    [Dictionary('PRO_CEST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CEST: String read FPRO_CEST write FPRO_CEST;
    const PRO_CEST_Name = 'PRO_CEST';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORCUSTOMERCADO', ftBCD, 1397311055, 2)]
    [Dictionary('PRO_VALORCUSTOMERCADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORCUSTOMERCADO: Double read FPRO_VALORCUSTOMERCADO write FPRO_VALORCUSTOMERCADO;
    const PRO_VALORCUSTOMERCADO_Name = 'PRO_VALORCUSTOMERCADO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOANP', ftString, 95)]
    [Dictionary('PRO_DESCRICAOANP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOANP: String read FPRO_DESCRICAOANP write FPRO_DESCRICAOANP;
    const PRO_DESCRICAOANP_Name = 'PRO_DESCRICAOANP';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALGASGLP', ftBCD, 218762555, 2)]
    [Dictionary('PRO_PERCENTUALGASGLP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALGASGLP: Double read FPRO_PERCENTUALGASGLP write FPRO_PERCENTUALGASGLP;
    const PRO_PERCENTUALGASGLP_Name = 'PRO_PERCENTUALGASGLP';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALGASGNN', ftBCD, 1952672068, 2)]
    [Dictionary('PRO_PERCENTUALGASGNN', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALGASGNN: Double read FPRO_PERCENTUALGASGNN write FPRO_PERCENTUALGASGNN;
    const PRO_PERCENTUALGASGNN_Name = 'PRO_PERCENTUALGASGNN';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALGASGNI', ftBCD, 537529693, 2)]
    [Dictionary('PRO_PERCENTUALGASGNI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALGASGNI: Double read FPRO_PERCENTUALGASGNI write FPRO_PERCENTUALGASGNI;
    const PRO_PERCENTUALGASGNI_Name = 'PRO_PERCENTUALGASGNI';

    [Restrictions([NoValidate])]
    [Column('PRO_QTDMETROCUBICO', ftBCD, 18, 4)]
    [Dictionary('PRO_QTDMETROCUBICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDMETROCUBICO: Double read FPRO_QTDMETROCUBICO write FPRO_QTDMETROCUBICO;
    const PRO_QTDMETROCUBICO_Name = 'PRO_QTDMETROCUBICO';

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
    [Column('PRO_QTDUNCAIXACODIGOBARRA', ftBCD, 1162039111, 3)]
    [Dictionary('PRO_QTDUNCAIXACODIGOBARRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDUNCAIXACODIGOBARRA: Double read FPRO_QTDUNCAIXACODIGOBARRA write FPRO_QTDUNCAIXACODIGOBARRA;
    const PRO_QTDUNCAIXACODIGOBARRA_Name = 'PRO_QTDUNCAIXACODIGOBARRA';

    [Restrictions([NoValidate])]
    [Column('PRO_OBSERVACAO', ftString, 300)]
    [Dictionary('PRO_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_OBSERVACAO: String read FPRO_OBSERVACAO write FPRO_OBSERVACAO;
    const PRO_OBSERVACAO_Name = 'PRO_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESATIVADO', ftString, 1)]
    [Dictionary('PRO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESATIVADO: String read FPRO_DESATIVADO write FPRO_DESATIVADO;
    const PRO_DESATIVADO_Name = 'PRO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGOTRIBUTAVEL', ftString, 2)]
    [Dictionary('SGM_CODIGOTRIBUTAVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGOTRIBUTAVEL: String read FSGM_CODIGOTRIBUTAVEL write FSGM_CODIGOTRIBUTAVEL;
    const SGM_CODIGOTRIBUTAVEL_Name = 'SGM_CODIGOTRIBUTAVEL';

    [Restrictions([NoValidate])]
    [Column('PRO_QUANTIDADETRIBUTAVEL', ftBCD, 18, 4)]
    [Dictionary('PRO_QUANTIDADETRIBUTAVEL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QUANTIDADETRIBUTAVEL: Double read FPRO_QUANTIDADETRIBUTAVEL write FPRO_QUANTIDADETRIBUTAVEL;
    const PRO_QUANTIDADETRIBUTAVEL_Name = 'PRO_QUANTIDADETRIBUTAVEL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00)

end.
