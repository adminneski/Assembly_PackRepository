unit Dto.VW_PSQ_PRO;

interface

uses
  System.SysUtils, 
  System.Classes, 
  Vcl.Graphics, 
  Data.DB, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes,
  //Application 
  Core.Mapping.Attributes;

type
  [Entity]
  [Table('VW_PSQ_PRO', '')]
  TDtoVW_PSQ_PRO = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FCOM_CODIGO: Integer;
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
    FETQ_ESTOQUEFILIAL: Double;
    FPRO_PRECOPEDIDO: Double;
  public 
    { Public declarations } 
    const Table      = 'VW_PSQ_PRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [ColumnDBGrid('PRO_CODIGO', 'PRO_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PRO_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [ColumnDBGrid('COM_CODIGO', 'COM_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('COM_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 401)]
    [ColumnDBGrid('PRO_DESCRICAO', 'PRO_DESCRICAO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_DESCRICAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [ColumnDBGrid('PRO_DESCRICAOADICIONAL', 'PRO_DESCRICAOADICIONAL', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [ColumnDBGrid('PRO_EMBALAGEM', 'PRO_EMBALAGEM', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_EMBALAGEM', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESATIVADO', ftString, 1)]
    [ColumnDBGrid('PRO_DESATIVADO', 'PRO_DESATIVADO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_DESATIVADO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_DESATIVADO: String read FPRO_DESATIVADO write FPRO_DESATIVADO;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOFINAL', ftString, 1)]
    [ColumnDBGrid('PRO_PRODUTOFINAL', 'PRO_PRODUTOFINAL', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_PRODUTOFINAL', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_PRODUTOFINAL: String read FPRO_PRODUTOFINAL write FPRO_PRODUTOFINAL;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOIMOBILIZADO', ftString, 1)]
    [ColumnDBGrid('PRO_PRODUTOIMOBILIZADO', 'PRO_PRODUTOIMOBILIZADO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_PRODUTOIMOBILIZADO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_PRODUTOIMOBILIZADO: String read FPRO_PRODUTOIMOBILIZADO write FPRO_PRODUTOIMOBILIZADO;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOMATERIAPRIMA', ftString, 1)]
    [ColumnDBGrid('PRO_PRODUTOMATERIAPRIMA', 'PRO_PRODUTOMATERIAPRIMA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_PRODUTOMATERIAPRIMA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_PRODUTOMATERIAPRIMA: String read FPRO_PRODUTOMATERIAPRIMA write FPRO_PRODUTOMATERIAPRIMA;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOPECAPRONTA', ftString, 1)]
    [ColumnDBGrid('PRO_PRODUTOPECAPRONTA', 'PRO_PRODUTOPECAPRONTA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_PRODUTOPECAPRONTA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_PRODUTOPECAPRONTA: String read FPRO_PRODUTOPECAPRONTA write FPRO_PRODUTOPECAPRONTA;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRODUTOCONSUMO', ftString, 1)]
    [ColumnDBGrid('PRO_PRODUTOCONSUMO', 'PRO_PRODUTOCONSUMO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_PRODUTOCONSUMO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_PRODUTOCONSUMO: String read FPRO_PRODUTOCONSUMO write FPRO_PRODUTOCONSUMO;

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [ColumnDBGrid('SGM_CODIGO', 'SGM_CODIGO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('SGM_CODIGO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;

    [Restrictions([NoValidate])]
    [Column('NCM_CODIGO', ftInteger)]
    [ColumnDBGrid('NCM_CODIGO', 'NCM_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('NCM_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [ColumnDBGrid('GRP_CODIGO', 'GRP_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('GRP_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [ColumnDBGrid('GRP_DESCRICAO', 'GRP_DESCRICAO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('GRP_DESCRICAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [ColumnDBGrid('SGP_CODIGO', 'SGP_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('SGP_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [ColumnDBGrid('SGP_DESCRICAO', 'SGP_DESCRICAO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('SGP_DESCRICAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [ColumnDBGrid('CLF_CODIGO', 'CLF_CODIGO', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('CLF_CODIGO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA1', ftString, 15)]
    [ColumnDBGrid('PRO_CODIGOBARRA1', 'PRO_CODIGOBARRA1', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_CODIGOBARRA1', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA1: String read FPRO_CODIGOBARRA1 write FPRO_CODIGOBARRA1;

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA2', ftString, 15)]
    [ColumnDBGrid('PRO_CODIGOBARRA2', 'PRO_CODIGOBARRA2', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_CODIGOBARRA2', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA2: String read FPRO_CODIGOBARRA2 write FPRO_CODIGOBARRA2;

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA3', ftString, 15)]
    [ColumnDBGrid('PRO_CODIGOBARRA3', 'PRO_CODIGOBARRA3', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_CODIGOBARRA3', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA3: String read FPRO_CODIGOBARRA3 write FPRO_CODIGOBARRA3;

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRACAIXA', ftString, 14)]
    [ColumnDBGrid('PRO_CODIGOBARRACAIXA', 'PRO_CODIGOBARRACAIXA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_CODIGOBARRACAIXA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRACAIXA: String read FPRO_CODIGOBARRACAIXA write FPRO_CODIGOBARRACAIXA;

    [Restrictions([NoValidate])]
    [Column('PRO_QTDUNCAIXACODIGOBARRA', ftBCD)]
    [ColumnDBGrid('PRO_QTDUNCAIXACODIGOBARRA', 'PRO_QTDUNCAIXACODIGOBARRA', 100, 'Arial', 10, clWindowText, False, taRightJustify, 'PSQ;')]
    [Dictionary('PRO_QTDUNCAIXACODIGOBARRA', 'Divergente do valor esperado.', '0', '', '', taRightJustify)]
    property PRO_QTDUNCAIXACODIGOBARRA: Double read FPRO_QTDUNCAIXACODIGOBARRA write FPRO_QTDUNCAIXACODIGOBARRA;

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [ColumnDBGrid('PRO_REFERENCIAINTERNA', 'PRO_REFERENCIAINTERNA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGOSIMILAR', ftString, 1)]
    [ColumnDBGrid('PRO_CODIGOSIMILAR', 'PRO_CODIGOSIMILAR', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PRO_CODIGOSIMILAR', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PRO_CODIGOSIMILAR: String read FPRO_CODIGOSIMILAR write FPRO_CODIGOSIMILAR;

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [ColumnDBGrid('ETQ_ESTOQUEFILIAL', 'ETQ_ESTOQUEFILIAL', 100, 'Arial', 10, clWindowText, False, taRightJustify, 'PSQ;')]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Divergente do valor esperado.', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOPEDIDO', ftBCD)]
    [ColumnDBGrid('PRO_PRECOPEDIDO', 'PRO_PRECOPEDIDO', 100, 'Arial', 10, clWindowText, False, taRightJustify, 'PSQ;')]
    [Dictionary('PRO_PRECOPEDIDO', 'Divergente do valor esperado.', '0', '', '', taRightJustify)]
    property PRO_PRECOPEDIDO: Double read FPRO_PRECOPEDIDO write FPRO_PRECOPEDIDO;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PRO)

end.
