unit express.dbo.REL_V01_FAT_06;

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
  [Table('REL_V01_FAT_06', '')]
  TDtoREL_V01_FAT_06 = class
  private
    { Private declarations } 
    FFAT_TIPO: String;
    FFAT_SIGLA: String;
    FCGA_ID: Integer;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_TIPOPESSOA: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FTRP_CODIGO: Integer;
    FROT_CODIGO: Integer;
    FFAT_NUMERODOCTO: String;
    FFAT_NOTAFISCAL: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FFAT_QTDFATURADA: Currency;
    FFAT_PRECOLIQUIDO: Double;
    FFAT_PRECOCUSTO: Double;
    FFAT_PRECODIGITADO: Double;
    FFAT_TOTALPRECOLIQUIDO: Double;
    FFAT_TOTALPRECOCUSTO: Double;
    FPRO_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FSGM_CODIGO: String;
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FGRP_DESCRICAO: String;
    FSGP_CODIGO: Integer;
    FSGP_SUBGRUPO: String;
    FSGP_DESCRICAO: String;
    FPES_NOME: String;
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
    FFAT_NFCUPOM: String;
    FFAT_INTEGRACAO: String;
    FFAT_PRECOTABELA: Double;
    FFAT_VALORDESCTOITEM: Double;
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
    FFAT_OBSERVACAOCANCELAMENTO: String;
    FFAT_DATACANCELAMENTO: TDateTime;
    FFAT_TIPOMOVTO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT_06';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_SIGLA', ftString, 3)]
    [Dictionary('FAT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SIGLA: String read FFAT_SIGLA write FFAT_SIGLA;
    const FAT_SIGLA_Name = 'FAT_SIGLA';

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
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('FAT_QTDFATURADA', ftCurrency)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Currency read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('FAT_PRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOLIQUIDO: Double read FFAT_PRECOLIQUIDO write FFAT_PRECOLIQUIDO;
    const FAT_PRECOLIQUIDO_Name = 'FAT_PRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('FAT_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOCUSTO: Double read FFAT_PRECOCUSTO write FFAT_PRECOCUSTO;
    const FAT_PRECOCUSTO_Name = 'FAT_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('FAT_PRECODIGITADO', ftBCD)]
    [Dictionary('FAT_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECODIGITADO: Double read FFAT_PRECODIGITADO write FFAT_PRECODIGITADO;
    const FAT_PRECODIGITADO_Name = 'FAT_PRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOLIQUIDO: Double read FFAT_TOTALPRECOLIQUIDO write FFAT_TOTALPRECOLIQUIDO;
    const FAT_TOTALPRECOLIQUIDO_Name = 'FAT_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOCUSTO: Double read FFAT_TOTALPRECOCUSTO write FFAT_TOTALPRECOCUSTO;
    const FAT_TOTALPRECOCUSTO_Name = 'FAT_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 300)]
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
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

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
    [Column('FAT_NFCUPOM', ftString, 10)]
    [Dictionary('FAT_NFCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NFCUPOM: String read FFAT_NFCUPOM write FFAT_NFCUPOM;
    const FAT_NFCUPOM_Name = 'FAT_NFCUPOM';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 3)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate])]
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
    [Column('FAT_PERCENTUALDESCTO', ftBCD)]
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
    [Column('FAT_TOTALCANCELADO', ftBCD, 10, 2)]
    [Dictionary('FAT_TOTALCANCELADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCANCELADO: Double read FFAT_TOTALCANCELADO write FFAT_TOTALCANCELADO;
    const FAT_TOTALCANCELADO_Name = 'FAT_TOTALCANCELADO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('FAT_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAOCANCELAMENTO: String read FFAT_OBSERVACAOCANCELAMENTO write FFAT_OBSERVACAOCANCELAMENTO;
    const FAT_OBSERVACAOCANCELAMENTO_Name = 'FAT_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('FAT_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATACANCELAMENTO: TDateTime read FFAT_DATACANCELAMENTO write FFAT_DATACANCELAMENTO;
    const FAT_DATACANCELAMENTO_Name = 'FAT_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOMOVTO', ftString, 3)]
    [Dictionary('FAT_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOMOVTO: String read FFAT_TIPOMOVTO write FFAT_TIPOMOVTO;
    const FAT_TIPOMOVTO_Name = 'FAT_TIPOMOVTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT_06)

end.
