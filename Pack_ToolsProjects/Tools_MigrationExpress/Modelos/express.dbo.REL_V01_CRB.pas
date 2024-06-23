unit express.dbo.REL_V01_CRB;

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
  [Table('REL_V01_CRB', '')]
  TDtoREL_V01_CRB = class
  private
    { Private declarations } 
    FCRB_ID: Integer;
    FCRB_INTEGRACAO: String;
    FCRB_TIPOMOVTO: String;
    FCRB_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCRB_DATAEMISSAO: TDateTime;
    FCRB_DATASAIDA: TDateTime;
    FTRP_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FVEI_PLACA_01: String;
    FVEI_PLACA_02: String;
    FVEI_PLACA_03: String;
    FVEI_DESCRICAO: String;
    FVEI_CIDADE: String;
    FVEI_UF: String;
    FCRB_NUMEROCONTRATO: String;
    FPES_CODIGOCONTRATANTE: Integer;
    FPES_CODIGOCONTRATADO: Integer;
    FCID_IBGEORIGEM: String;
    FCRB_CIDADEORIGEM: String;
    FCRB_UFORIGEM: String;
    FCID_IBGEDESTINO: String;
    FCRB_CIDADEDESTINO: String;
    FCRB_UFDESTINO: String;
    FCRB_CONDICAOESPECIAL: String;
    FCRB_MERCADORIATRANSPORTADA: String;
    FCRB_ESPECIEVOLUMES: String;
    FCRB_TOTALAJUSTE: Double;
    FCRB_TOTALNUMEROVOLUMES: Double;
    FCRB_TOTALPESO: Double;
    FCRB_TOTALIRRF: Double;
    FCRB_TOTALINSS: Double;
    FCRB_TOTALFRETE: Double;
    FCRB_TOTALMULTA: Double;
    FCRB_TOTALPEDAGIO: Double;
    FCRB_TOTALOUTROS: Double;
    FCRB_TOTALREEMBOLSO: Double;
    FCRB_TOTALSEST_SENAC: Double;
    FCRB_TOTALADIANTAMENTO: Double;
    FCRB_TOTALCONTRATO: Double;
    FCRB_TOTALCONTRATOCANCELADO: Double;
    FCRB_CANCELADO: String;
    FPES_NOMECONTRATANTE: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FCID_IBGE: String;
    FPES_TIPOPESSOA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FCEP_CODIGO: String;
    FPES_BAIRRO: String;
    FPES_TRP: Integer;
    FPES_TIPOPESSOA_TRP: String;
    FPES_NOME_TRP: String;
    FPES_CNPJ_CPF_TRP: String;
    FPES_IE_CI_TRP: String;
    FPES_HABILITACAO_TRP: String;
    FPES_UFHABILITACAO_TRP: String;
    FPES_INSCRICAOINSS_TRP: String;
    FPES_DATAEMISSAOHABILITACAO_TRP: TDateTime;
    FPES_CEP_TRP: String;
    FCID_IBGE_TRP: String;
    FPES_CIDADE_TRP: String;
    FPES_UF_TRP: String;
    FPES_ENDERECO_TRP: String;
    FPES_NUMEROENDERECO_TRP: String;
    FPES_BAIRRO_TRP: String;
    FPES_DDD_TELEFONE_1_TRP: String;
    FPES_PROPRITARIO_VEI: Integer;
    FPES_TIPOPESSOA_PROPRITARIO_VEI: String;
    FPES_NOME_PROPRITARIO_VEI: String;
    FPES_CNPJ_CPF_PROPRITARIO_VEI: String;
    FPES_IE_CI_PROPRITARIO_VEI: String;
    FPES_CEP_PROPRITARIO_VEI: String;
    FCID_IBGE_PROPRITARIO_VEI: String;
    FPES_CIDADE_PROPRITARIO_VEI: String;
    FPES_UF_PROPRITARIO_VEI: String;
    FPES_ENDERECO_PROPRITARIO_VEI: String;
    FPES_NUMEROENDERECO_PROPRITARIO_VEI: String;
    FPES_BAIRRO_PROPRITARIO_VEI: String;
    FPES_DDD_TELEFONE_1_PROPRITARIO_VEI: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CRB';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_ID', ftInteger)]
    [Dictionary('CRB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_ID: Integer read FCRB_ID write FCRB_ID;
    const CRB_ID_Name = 'CRB_ID';

    [Restrictions([NoValidate])]
    [Column('CRB_INTEGRACAO', ftString, 20)]
    [Dictionary('CRB_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_INTEGRACAO: String read FCRB_INTEGRACAO write FCRB_INTEGRACAO;
    const CRB_INTEGRACAO_Name = 'CRB_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CRB_TIPOMOVTO', ftString, 3)]
    [Dictionary('CRB_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_TIPOMOVTO: String read FCRB_TIPOMOVTO write FCRB_TIPOMOVTO;
    const CRB_TIPOMOVTO_Name = 'CRB_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('CRB_NOTAFISCAL', ftString, 500)]
    [Dictionary('CRB_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NOTAFISCAL: String read FCRB_NOTAFISCAL write FCRB_NOTAFISCAL;
    const CRB_NOTAFISCAL_Name = 'CRB_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRB_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATAEMISSAO: TDateTime read FCRB_DATAEMISSAO write FCRB_DATAEMISSAO;
    const CRB_DATAEMISSAO_Name = 'CRB_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATASAIDA', ftDateTime)]
    [Dictionary('CRB_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATASAIDA: TDateTime read FCRB_DATASAIDA write FCRB_DATASAIDA;
    const CRB_DATASAIDA_Name = 'CRB_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA_01', ftString, 7)]
    [Dictionary('VEI_PLACA_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA_01: String read FVEI_PLACA_01 write FVEI_PLACA_01;
    const VEI_PLACA_01_Name = 'VEI_PLACA_01';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA_02', ftString, 7)]
    [Dictionary('VEI_PLACA_02', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA_02: String read FVEI_PLACA_02 write FVEI_PLACA_02;
    const VEI_PLACA_02_Name = 'VEI_PLACA_02';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA_03', ftString, 7)]
    [Dictionary('VEI_PLACA_03', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA_03: String read FVEI_PLACA_03 write FVEI_PLACA_03;
    const VEI_PLACA_03_Name = 'VEI_PLACA_03';

    [Restrictions([NoValidate])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_CIDADE', ftString, 100)]
    [Dictionary('VEI_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_CIDADE: String read FVEI_CIDADE write FVEI_CIDADE;
    const VEI_CIDADE_Name = 'VEI_CIDADE';

    [Restrictions([NoValidate])]
    [Column('VEI_UF', ftString, 2)]
    [Dictionary('VEI_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_UF: String read FVEI_UF write FVEI_UF;
    const VEI_UF_Name = 'VEI_UF';

    [Restrictions([NoValidate])]
    [Column('CRB_NUMEROCONTRATO', ftString, 6)]
    [Dictionary('CRB_NUMEROCONTRATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NUMEROCONTRATO: String read FCRB_NUMEROCONTRATO write FCRB_NUMEROCONTRATO;
    const CRB_NUMEROCONTRATO_Name = 'CRB_NUMEROCONTRATO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCONTRATANTE', ftInteger)]
    [Dictionary('PES_CODIGOCONTRATANTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCONTRATANTE: Integer read FPES_CODIGOCONTRATANTE write FPES_CODIGOCONTRATANTE;
    const PES_CODIGOCONTRATANTE_Name = 'PES_CODIGOCONTRATANTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCONTRATADO', ftInteger)]
    [Dictionary('PES_CODIGOCONTRATADO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCONTRATADO: Integer read FPES_CODIGOCONTRATADO write FPES_CODIGOCONTRATADO;
    const PES_CODIGOCONTRATADO_Name = 'PES_CODIGOCONTRATADO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftString, 7)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEORIGEM: String read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CRB_CIDADEORIGEM', ftString, 100)]
    [Dictionary('CRB_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CIDADEORIGEM: String read FCRB_CIDADEORIGEM write FCRB_CIDADEORIGEM;
    const CRB_CIDADEORIGEM_Name = 'CRB_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CRB_UFORIGEM', ftString, 2)]
    [Dictionary('CRB_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_UFORIGEM: String read FCRB_UFORIGEM write FCRB_UFORIGEM;
    const CRB_UFORIGEM_Name = 'CRB_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftString, 7)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEDESTINO: String read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CRB_CIDADEDESTINO', ftString, 100)]
    [Dictionary('CRB_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CIDADEDESTINO: String read FCRB_CIDADEDESTINO write FCRB_CIDADEDESTINO;
    const CRB_CIDADEDESTINO_Name = 'CRB_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CRB_UFDESTINO', ftString, 2)]
    [Dictionary('CRB_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_UFDESTINO: String read FCRB_UFDESTINO write FCRB_UFDESTINO;
    const CRB_UFDESTINO_Name = 'CRB_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CRB_CONDICAOESPECIAL', ftString, 300)]
    [Dictionary('CRB_CONDICAOESPECIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CONDICAOESPECIAL: String read FCRB_CONDICAOESPECIAL write FCRB_CONDICAOESPECIAL;
    const CRB_CONDICAOESPECIAL_Name = 'CRB_CONDICAOESPECIAL';

    [Restrictions([NoValidate])]
    [Column('CRB_MERCADORIATRANSPORTADA', ftString, 300)]
    [Dictionary('CRB_MERCADORIATRANSPORTADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_MERCADORIATRANSPORTADA: String read FCRB_MERCADORIATRANSPORTADA write FCRB_MERCADORIATRANSPORTADA;
    const CRB_MERCADORIATRANSPORTADA_Name = 'CRB_MERCADORIATRANSPORTADA';

    [Restrictions([NoValidate])]
    [Column('CRB_ESPECIEVOLUMES', ftString, 15)]
    [Dictionary('CRB_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_ESPECIEVOLUMES: String read FCRB_ESPECIEVOLUMES write FCRB_ESPECIEVOLUMES;
    const CRB_ESPECIEVOLUMES_Name = 'CRB_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CRB_TOTALAJUSTE', ftBCD, 48, 2)]
    [Dictionary('CRB_TOTALAJUSTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALAJUSTE: Double read FCRB_TOTALAJUSTE write FCRB_TOTALAJUSTE;
    const CRB_TOTALAJUSTE_Name = 'CRB_TOTALAJUSTE';

    [Restrictions([NoValidate])]
    [Column('CRB_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('CRB_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALNUMEROVOLUMES: Double read FCRB_TOTALNUMEROVOLUMES write FCRB_TOTALNUMEROVOLUMES;
    const CRB_TOTALNUMEROVOLUMES_Name = 'CRB_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALPESO', ftBCD)]
    [Dictionary('CRB_TOTALPESO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALPESO: Double read FCRB_TOTALPESO write FCRB_TOTALPESO;
    const CRB_TOTALPESO_Name = 'CRB_TOTALPESO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALIRRF', ftBCD)]
    [Dictionary('CRB_TOTALIRRF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALIRRF: Double read FCRB_TOTALIRRF write FCRB_TOTALIRRF;
    const CRB_TOTALIRRF_Name = 'CRB_TOTALIRRF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALINSS', ftBCD, 48, 2)]
    [Dictionary('CRB_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALINSS: Double read FCRB_TOTALINSS write FCRB_TOTALINSS;
    const CRB_TOTALINSS_Name = 'CRB_TOTALINSS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALFRETE', ftBCD)]
    [Dictionary('CRB_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALFRETE: Double read FCRB_TOTALFRETE write FCRB_TOTALFRETE;
    const CRB_TOTALFRETE_Name = 'CRB_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALMULTA', ftBCD)]
    [Dictionary('CRB_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALMULTA: Double read FCRB_TOTALMULTA write FCRB_TOTALMULTA;
    const CRB_TOTALMULTA_Name = 'CRB_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALPEDAGIO', ftBCD)]
    [Dictionary('CRB_TOTALPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALPEDAGIO: Double read FCRB_TOTALPEDAGIO write FCRB_TOTALPEDAGIO;
    const CRB_TOTALPEDAGIO_Name = 'CRB_TOTALPEDAGIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALOUTROS', ftBCD)]
    [Dictionary('CRB_TOTALOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALOUTROS: Double read FCRB_TOTALOUTROS write FCRB_TOTALOUTROS;
    const CRB_TOTALOUTROS_Name = 'CRB_TOTALOUTROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALREEMBOLSO', ftBCD)]
    [Dictionary('CRB_TOTALREEMBOLSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALREEMBOLSO: Double read FCRB_TOTALREEMBOLSO write FCRB_TOTALREEMBOLSO;
    const CRB_TOTALREEMBOLSO_Name = 'CRB_TOTALREEMBOLSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALSEST_SENAC', ftBCD)]
    [Dictionary('CRB_TOTALSEST_SENAC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALSEST_SENAC: Double read FCRB_TOTALSEST_SENAC write FCRB_TOTALSEST_SENAC;
    const CRB_TOTALSEST_SENAC_Name = 'CRB_TOTALSEST_SENAC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALADIANTAMENTO', ftBCD, 48, 2)]
    [Dictionary('CRB_TOTALADIANTAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALADIANTAMENTO: Double read FCRB_TOTALADIANTAMENTO write FCRB_TOTALADIANTAMENTO;
    const CRB_TOTALADIANTAMENTO_Name = 'CRB_TOTALADIANTAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALCONTRATO', ftBCD)]
    [Dictionary('CRB_TOTALCONTRATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALCONTRATO: Double read FCRB_TOTALCONTRATO write FCRB_TOTALCONTRATO;
    const CRB_TOTALCONTRATO_Name = 'CRB_TOTALCONTRATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALCONTRATOCANCELADO', ftBCD)]
    [Dictionary('CRB_TOTALCONTRATOCANCELADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALCONTRATOCANCELADO: Double read FCRB_TOTALCONTRATOCANCELADO write FCRB_TOTALCONTRATOCANCELADO;
    const CRB_TOTALCONTRATOCANCELADO_Name = 'CRB_TOTALCONTRATOCANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_CANCELADO', ftString, 1)]
    [Dictionary('CRB_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CANCELADO: String read FCRB_CANCELADO write FCRB_CANCELADO;
    const CRB_CANCELADO_Name = 'CRB_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECONTRATANTE', ftString, 100)]
    [Dictionary('PES_NOMECONTRATANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONTRATANTE: String read FPES_NOMECONTRATANTE write FPES_NOMECONTRATANTE;
    const PES_NOMECONTRATANTE_Name = 'PES_NOMECONTRATANTE';

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
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

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
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('PES_TRP', ftInteger)]
    [Dictionary('PES_TRP', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_TRP: Integer read FPES_TRP write FPES_TRP;
    const PES_TRP_Name = 'PES_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_TRP', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_TRP: String read FPES_TIPOPESSOA_TRP write FPES_TIPOPESSOA_TRP;
    const PES_TIPOPESSOA_TRP_Name = 'PES_TIPOPESSOA_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_TRP', ftString, 100)]
    [Dictionary('PES_NOME_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_TRP: String read FPES_NOME_TRP write FPES_NOME_TRP;
    const PES_NOME_TRP_Name = 'PES_NOME_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_TRP', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_TRP: String read FPES_CNPJ_CPF_TRP write FPES_CNPJ_CPF_TRP;
    const PES_CNPJ_CPF_TRP_Name = 'PES_CNPJ_CPF_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_TRP', ftString, 16)]
    [Dictionary('PES_IE_CI_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_TRP: String read FPES_IE_CI_TRP write FPES_IE_CI_TRP;
    const PES_IE_CI_TRP_Name = 'PES_IE_CI_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_HABILITACAO_TRP', ftString, 20)]
    [Dictionary('PES_HABILITACAO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_HABILITACAO_TRP: String read FPES_HABILITACAO_TRP write FPES_HABILITACAO_TRP;
    const PES_HABILITACAO_TRP_Name = 'PES_HABILITACAO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_UFHABILITACAO_TRP', ftString, 2)]
    [Dictionary('PES_UFHABILITACAO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFHABILITACAO_TRP: String read FPES_UFHABILITACAO_TRP write FPES_UFHABILITACAO_TRP;
    const PES_UFHABILITACAO_TRP_Name = 'PES_UFHABILITACAO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_INSCRICAOINSS_TRP', ftString, 20)]
    [Dictionary('PES_INSCRICAOINSS_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_INSCRICAOINSS_TRP: String read FPES_INSCRICAOINSS_TRP write FPES_INSCRICAOINSS_TRP;
    const PES_INSCRICAOINSS_TRP_Name = 'PES_INSCRICAOINSS_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_DATAEMISSAOHABILITACAO_TRP', ftDateTime)]
    [Dictionary('PES_DATAEMISSAOHABILITACAO_TRP', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAEMISSAOHABILITACAO_TRP: TDateTime read FPES_DATAEMISSAOHABILITACAO_TRP write FPES_DATAEMISSAOHABILITACAO_TRP;
    const PES_DATAEMISSAOHABILITACAO_TRP_Name = 'PES_DATAEMISSAOHABILITACAO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_TRP', ftString, 8)]
    [Dictionary('PES_CEP_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_TRP: String read FPES_CEP_TRP write FPES_CEP_TRP;
    const PES_CEP_TRP_Name = 'PES_CEP_TRP';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_TRP', ftString, 7)]
    [Dictionary('CID_IBGE_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_TRP: String read FCID_IBGE_TRP write FCID_IBGE_TRP;
    const CID_IBGE_TRP_Name = 'CID_IBGE_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_TRP', ftString, 100)]
    [Dictionary('PES_CIDADE_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_TRP: String read FPES_CIDADE_TRP write FPES_CIDADE_TRP;
    const PES_CIDADE_TRP_Name = 'PES_CIDADE_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_UF_TRP', ftString, 2)]
    [Dictionary('PES_UF_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_TRP: String read FPES_UF_TRP write FPES_UF_TRP;
    const PES_UF_TRP_Name = 'PES_UF_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_TRP', ftString, 100)]
    [Dictionary('PES_ENDERECO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_TRP: String read FPES_ENDERECO_TRP write FPES_ENDERECO_TRP;
    const PES_ENDERECO_TRP_Name = 'PES_ENDERECO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_TRP', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_TRP: String read FPES_NUMEROENDERECO_TRP write FPES_NUMEROENDERECO_TRP;
    const PES_NUMEROENDERECO_TRP_Name = 'PES_NUMEROENDERECO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_TRP', ftString, 50)]
    [Dictionary('PES_BAIRRO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_TRP: String read FPES_BAIRRO_TRP write FPES_BAIRRO_TRP;
    const PES_BAIRRO_TRP_Name = 'PES_BAIRRO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_TRP', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_TRP: String read FPES_DDD_TELEFONE_1_TRP write FPES_DDD_TELEFONE_1_TRP;
    const PES_DDD_TELEFONE_1_TRP_Name = 'PES_DDD_TELEFONE_1_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_PROPRITARIO_VEI', ftInteger)]
    [Dictionary('PES_PROPRITARIO_VEI', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_PROPRITARIO_VEI: Integer read FPES_PROPRITARIO_VEI write FPES_PROPRITARIO_VEI;
    const PES_PROPRITARIO_VEI_Name = 'PES_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_PROPRITARIO_VEI', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_PROPRITARIO_VEI: String read FPES_TIPOPESSOA_PROPRITARIO_VEI write FPES_TIPOPESSOA_PROPRITARIO_VEI;
    const PES_TIPOPESSOA_PROPRITARIO_VEI_Name = 'PES_TIPOPESSOA_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_PROPRITARIO_VEI', ftString, 100)]
    [Dictionary('PES_NOME_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_PROPRITARIO_VEI: String read FPES_NOME_PROPRITARIO_VEI write FPES_NOME_PROPRITARIO_VEI;
    const PES_NOME_PROPRITARIO_VEI_Name = 'PES_NOME_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_PROPRITARIO_VEI', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_PROPRITARIO_VEI: String read FPES_CNPJ_CPF_PROPRITARIO_VEI write FPES_CNPJ_CPF_PROPRITARIO_VEI;
    const PES_CNPJ_CPF_PROPRITARIO_VEI_Name = 'PES_CNPJ_CPF_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_PROPRITARIO_VEI', ftString, 16)]
    [Dictionary('PES_IE_CI_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_PROPRITARIO_VEI: String read FPES_IE_CI_PROPRITARIO_VEI write FPES_IE_CI_PROPRITARIO_VEI;
    const PES_IE_CI_PROPRITARIO_VEI_Name = 'PES_IE_CI_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_PROPRITARIO_VEI', ftString, 8)]
    [Dictionary('PES_CEP_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_PROPRITARIO_VEI: String read FPES_CEP_PROPRITARIO_VEI write FPES_CEP_PROPRITARIO_VEI;
    const PES_CEP_PROPRITARIO_VEI_Name = 'PES_CEP_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_PROPRITARIO_VEI', ftString, 7)]
    [Dictionary('CID_IBGE_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_PROPRITARIO_VEI: String read FCID_IBGE_PROPRITARIO_VEI write FCID_IBGE_PROPRITARIO_VEI;
    const CID_IBGE_PROPRITARIO_VEI_Name = 'CID_IBGE_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_PROPRITARIO_VEI', ftString, 100)]
    [Dictionary('PES_CIDADE_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_PROPRITARIO_VEI: String read FPES_CIDADE_PROPRITARIO_VEI write FPES_CIDADE_PROPRITARIO_VEI;
    const PES_CIDADE_PROPRITARIO_VEI_Name = 'PES_CIDADE_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_UF_PROPRITARIO_VEI', ftString, 2)]
    [Dictionary('PES_UF_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_PROPRITARIO_VEI: String read FPES_UF_PROPRITARIO_VEI write FPES_UF_PROPRITARIO_VEI;
    const PES_UF_PROPRITARIO_VEI_Name = 'PES_UF_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_PROPRITARIO_VEI', ftString, 100)]
    [Dictionary('PES_ENDERECO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_PROPRITARIO_VEI: String read FPES_ENDERECO_PROPRITARIO_VEI write FPES_ENDERECO_PROPRITARIO_VEI;
    const PES_ENDERECO_PROPRITARIO_VEI_Name = 'PES_ENDERECO_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_PROPRITARIO_VEI', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_PROPRITARIO_VEI: String read FPES_NUMEROENDERECO_PROPRITARIO_VEI write FPES_NUMEROENDERECO_PROPRITARIO_VEI;
    const PES_NUMEROENDERECO_PROPRITARIO_VEI_Name = 'PES_NUMEROENDERECO_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_PROPRITARIO_VEI', ftString, 50)]
    [Dictionary('PES_BAIRRO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_PROPRITARIO_VEI: String read FPES_BAIRRO_PROPRITARIO_VEI write FPES_BAIRRO_PROPRITARIO_VEI;
    const PES_BAIRRO_PROPRITARIO_VEI_Name = 'PES_BAIRRO_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_PROPRITARIO_VEI', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_PROPRITARIO_VEI: String read FPES_DDD_TELEFONE_1_PROPRITARIO_VEI write FPES_DDD_TELEFONE_1_PROPRITARIO_VEI;
    const PES_DDD_TELEFONE_1_PROPRITARIO_VEI_Name = 'PES_DDD_TELEFONE_1_PROPRITARIO_VEI';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CRB)

end.
