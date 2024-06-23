unit express.dbo.REL_V01_FAT_01;

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
  [Table('REL_V01_FAT_01', '')]
  TDtoREL_V01_FAT_01 = class
  private
    { Private declarations } 
    FFAT_TIPO: String;
    FCGA_ID: Integer;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_TIPOPESSOA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_1: String;
    FCEP_CODIGO: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FTRP_CODIGO: Integer;
    FROT_CODIGO: Integer;
    FFAT_NUMERODOCTO: String;
    FFAT_NOTAFISCAL: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FFAT_QTDFATURADA: Double;
    FFAT_QTDDEVOLVIDA: Double;
    FFAT_PRECOLIQUIDO: Double;
    FFAT_PRECOCUSTO: Double;
    FFAT_PRECODIGITADO: Double;
    FFAT_PRECOBASEVENDA: Double;
    FFAT_TOTALPRECOBASEVENDA: Double;
    FFAT_TOTALPRECOLIQUIDO: Double;
    FFAT_TOTALPRECOCUSTO: Double;
    FFAT_TOTALPRECODIGITADO: Double;
    FFAT_TOTALPRECOTABELA: Double;
    FPRO_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FSGM_CODIGO: String;
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FGRP_DESCRICAO: String;
    FSGP_CODIGO: Integer;
    FSGP_SUBGRUPO: String;
    FSGP_DESCRICAO: String;
    FPRO_REFERENCIAINTERNA: String;
    FFAT_DESATIVADO: String;
    FFAT_CANCELADA: String;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
    FPRO_DESCRICAOADICIONAL: String;
    FNTO_MODELOOPERACAO: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FLCZ_ETIQUETALOCALIZACAO: String;
    FPRO_PESOBRUTO: Double;
    FPRO_NOMEAPELIDO: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FFAT_NFCUPOM: String;
    FFAT_INTEGRACAO: String;
    FFAT_PRECOTABELA: Double;
    FFAT_VALORDESCTOITEM: Double;
    FFAT_TOTALDESCTOITEM: Double;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FFAT_PERCENTUALDESCTO: Double;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
    FFAT_NOTAFISCALREAL: String;
    FCCU_CODIGO: Integer;
    FSEG_CODIGO: Integer;
    FFAT_CODIGOESTRUTURADO: String;
    FUSERS_LOGIN: String;
    FFAT_TOTALCANCELADO: Double;
    FFAT_TOTALPRECOSEM_IPI_ICMSR: Double;
    FCSTPC_CODIGO: String;
    FFAT_PERCENTUALICMSITEM: Double;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FGRD_CODIGO: String;
    FPRO_QTDMETROCUBICO: Double;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 6)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Double read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDDEVOLVIDA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDDEVOLVIDA: Double read FFAT_QTDDEVOLVIDA write FFAT_QTDDEVOLVIDA;
    const FAT_QTDDEVOLVIDA_Name = 'FAT_QTDDEVOLVIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOLIQUIDO: Double read FFAT_PRECOLIQUIDO write FFAT_PRECOLIQUIDO;
    const FAT_PRECOLIQUIDO_Name = 'FAT_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOCUSTO: Double read FFAT_PRECOCUSTO write FFAT_PRECOCUSTO;
    const FAT_PRECOCUSTO_Name = 'FAT_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECODIGITADO', ftBCD)]
    [Dictionary('FAT_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECODIGITADO: Double read FFAT_PRECODIGITADO write FFAT_PRECODIGITADO;
    const FAT_PRECODIGITADO_Name = 'FAT_PRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('FAT_PRECOBASEVENDA', ftBCD)]
    [Dictionary('FAT_PRECOBASEVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOBASEVENDA: Double read FFAT_PRECOBASEVENDA write FFAT_PRECOBASEVENDA;
    const FAT_PRECOBASEVENDA_Name = 'FAT_PRECOBASEVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOBASEVENDA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOBASEVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOBASEVENDA: Double read FFAT_TOTALPRECOBASEVENDA write FFAT_TOTALPRECOBASEVENDA;
    const FAT_TOTALPRECOBASEVENDA_Name = 'FAT_TOTALPRECOBASEVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOLIQUIDO', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOLIQUIDO: Double read FFAT_TOTALPRECOLIQUIDO write FFAT_TOTALPRECOLIQUIDO;
    const FAT_TOTALPRECOLIQUIDO_Name = 'FAT_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOCUSTO: Double read FFAT_TOTALPRECOCUSTO write FFAT_TOTALPRECOCUSTO;
    const FAT_TOTALPRECOCUSTO_Name = 'FAT_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECODIGITADO', ftBCD)]
    [Dictionary('FAT_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECODIGITADO: Double read FFAT_TOTALPRECODIGITADO write FFAT_TOTALPRECODIGITADO;
    const FAT_TOTALPRECODIGITADO_Name = 'FAT_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOTABELA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOTABELA: Double read FFAT_TOTALPRECOTABELA write FFAT_TOTALPRECOTABELA;
    const FAT_TOTALPRECOTABELA_Name = 'FAT_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

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
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

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
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

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
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

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

    [Restrictions([NoValidate])]
    [Column('PRO_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PRO_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PESOBRUTO: Double read FPRO_PESOBRUTO write FPRO_PESOBRUTO;
    const PRO_PESOBRUTO_Name = 'PRO_PESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('PRO_NOMEAPELIDO', ftString, 30)]
    [Dictionary('PRO_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOMEAPELIDO: String read FPRO_NOMEAPELIDO write FPRO_NOMEAPELIDO;
    const PRO_NOMEAPELIDO_Name = 'PRO_NOMEAPELIDO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('FAT_NFCUPOM', ftString, 10)]
    [Dictionary('FAT_NFCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NFCUPOM: String read FFAT_NFCUPOM write FFAT_NFCUPOM;
    const FAT_NFCUPOM_Name = 'FAT_NFCUPOM';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 3)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOTABELA: Double read FFAT_PRECOTABELA write FFAT_PRECOTABELA;
    const FAT_PRECOTABELA_Name = 'FAT_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORDESCTOITEM', ftBCD)]
    [Dictionary('FAT_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORDESCTOITEM: Double read FFAT_VALORDESCTOITEM write FFAT_VALORDESCTOITEM;
    const FAT_VALORDESCTOITEM_Name = 'FAT_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOITEM: Double read FFAT_TOTALDESCTOITEM write FFAT_TOTALDESCTOITEM;
    const FAT_TOTALDESCTOITEM_Name = 'FAT_TOTALDESCTOITEM';

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
    [Column('FAT_PERCENTUALDESCTO', ftBCD, 10, 10)]
    [Dictionary('FAT_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCTO: Double read FFAT_PERCENTUALDESCTO write FFAT_PERCENTUALDESCTO;
    const FAT_PERCENTUALDESCTO_Name = 'FAT_PERCENTUALDESCTO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO', ftString, 100)]
    [Dictionary('PES_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO: String read FPES_ENDERECO write FPES_ENDERECO;
    const PES_ENDERECO_Name = 'PES_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO: String read FPES_NUMEROENDERECO write FPES_NUMEROENDERECO;
    const PES_NUMEROENDERECO_Name = 'PES_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCALREAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCALREAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCALREAL: String read FFAT_NOTAFISCALREAL write FFAT_NOTAFISCALREAL;
    const FAT_NOTAFISCALREAL_Name = 'FAT_NOTAFISCALREAL';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SEG_CODIGO', ftInteger)]
    [Dictionary('SEG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SEG_CODIGO: Integer read FSEG_CODIGO write FSEG_CODIGO;
    const SEG_CODIGO_Name = 'SEG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_CODIGOESTRUTURADO', ftString, 30)]
    [Dictionary('FAT_CODIGOESTRUTURADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CODIGOESTRUTURADO: String read FFAT_CODIGOESTRUTURADO write FFAT_CODIGOESTRUTURADO;
    const FAT_CODIGOESTRUTURADO_Name = 'FAT_CODIGOESTRUTURADO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCANCELADO', ftBCD)]
    [Dictionary('FAT_TOTALCANCELADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCANCELADO: Double read FFAT_TOTALCANCELADO write FFAT_TOTALCANCELADO;
    const FAT_TOTALCANCELADO_Name = 'FAT_TOTALCANCELADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOSEM_IPI_ICMSR', ftBCD, 66260064, 2)]
    [Dictionary('FAT_TOTALPRECOSEM_IPI_ICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOSEM_IPI_ICMSR: Double read FFAT_TOTALPRECOSEM_IPI_ICMSR write FFAT_TOTALPRECOSEM_IPI_ICMSR;
    const FAT_TOTALPRECOSEM_IPI_ICMSR_Name = 'FAT_TOTALPRECOSEM_IPI_ICMSR';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('FAT_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALICMSITEM: Double read FFAT_PERCENTUALICMSITEM write FFAT_PERCENTUALICMSITEM;
    const FAT_PERCENTUALICMSITEM_Name = 'FAT_PERCENTUALICMSITEM';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_QTDMETROCUBICO', ftBCD, 18, 4)]
    [Dictionary('PRO_QTDMETROCUBICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDMETROCUBICO: Double read FPRO_QTDMETROCUBICO write FPRO_QTDMETROCUBICO;
    const PRO_QTDMETROCUBICO_Name = 'PRO_QTDMETROCUBICO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT_01)

end.
