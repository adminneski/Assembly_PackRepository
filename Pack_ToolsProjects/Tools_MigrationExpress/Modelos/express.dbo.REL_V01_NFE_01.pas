unit express.dbo.REL_V01_NFE_01;

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
  [Table('REL_V01_NFE_01', '')]
  TDtoREL_V01_NFE_01 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_TIPOPESSOA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_1: String;
    FCEP_CODIGO: String;
    FROT_CODIGO: Integer;
    FNFE_NOTAFISCAL: String;
    FNFE_DATALANCAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FNFE_QTDENTRADA: Double;
    FNFE_VALORITEM: Double;
    FNFE_ULTIMOCUSTOCOMPRA: Double;
    FNFE_TOTALITEM: Double;
    FNFE_TOTALULTIMOCUSTOCOMPRA: Double;
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
    FNFE_CANCELADA: String;
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
    FNFE_VALORDESCTOITEM: Double;
    FNFE_TOTALDESCTOITEM: Double;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FNFE_PERCENTUALDESCTO: Double;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FNFE_NOTAFISCALREAL: String;
    FCCU_CODIGO: Integer;
    FSEG_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_NFE_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

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
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFE_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATALANCAMENTO: TDateTime read FNFE_DATALANCAMENTO write FNFE_DATALANCAMENTO;
    const NFE_DATALANCAMENTO_Name = 'NFE_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORITEM', ftBCD)]
    [Dictionary('NFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORITEM: Double read FNFE_VALORITEM write FNFE_VALORITEM;
    const NFE_VALORITEM_Name = 'NFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMOCUSTOCOMPRA', ftBCD)]
    [Dictionary('NFE_ULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_ULTIMOCUSTOCOMPRA: Double read FNFE_ULTIMOCUSTOCOMPRA write FNFE_ULTIMOCUSTOCOMPRA;
    const NFE_ULTIMOCUSTOCOMPRA_Name = 'NFE_ULTIMOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALITEM', ftBCD)]
    [Dictionary('NFE_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALITEM: Double read FNFE_TOTALITEM write FNFE_TOTALITEM;
    const NFE_TOTALITEM_Name = 'NFE_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALULTIMOCUSTOCOMPRA', ftBCD)]
    [Dictionary('NFE_TOTALULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALULTIMOCUSTOCOMPRA: Double read FNFE_TOTALULTIMOCUSTOCOMPRA write FNFE_TOTALULTIMOCUSTOCOMPRA;
    const NFE_TOTALULTIMOCUSTOCOMPRA_Name = 'NFE_TOTALULTIMOCUSTOCOMPRA';

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
    [Column('NFE_CANCELADA', ftString, 1)]
    [Dictionary('NFE_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CANCELADA: String read FNFE_CANCELADA write FNFE_CANCELADA;
    const NFE_CANCELADA_Name = 'NFE_CANCELADA';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORDESCTOITEM', ftBCD)]
    [Dictionary('NFE_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORDESCTOITEM: Double read FNFE_VALORDESCTOITEM write FNFE_VALORDESCTOITEM;
    const NFE_VALORDESCTOITEM_Name = 'NFE_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('NFE_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('NFE_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALDESCTOITEM: Double read FNFE_TOTALDESCTOITEM write FNFE_TOTALDESCTOITEM;
    const NFE_TOTALDESCTOITEM_Name = 'NFE_TOTALDESCTOITEM';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PERCENTUALDESCTO', ftBCD, 18, 4)]
    [Dictionary('NFE_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALDESCTO: Double read FNFE_PERCENTUALDESCTO write FNFE_PERCENTUALDESCTO;
    const NFE_PERCENTUALDESCTO_Name = 'NFE_PERCENTUALDESCTO';

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
    [Column('NFE_NOTAFISCALREAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCALREAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCALREAL: String read FNFE_NOTAFISCALREAL write FNFE_NOTAFISCALREAL;
    const NFE_NOTAFISCALREAL_Name = 'NFE_NOTAFISCALREAL';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_NFE_01)

end.
