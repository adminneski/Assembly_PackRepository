unit express.dbo.REL_V01_CFR;

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
  [Table('REL_V01_CFR', '')]
  TDtoREL_V01_CFR = class
  private
    { Private declarations } 
    FCFR_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FTRP_NOME: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVEI_CODIGO: Integer;
    FCFR_DATALANCAMENTO: TDateTime;
    FCFR_CARTAFRETE: String;
    FCFR_NOTAFISCAL: String;
    FCFR_CONHECIMENTO: String;
    FCID_IBGEORIGEM: String;
    FCFR_CIDADEORIGEM: String;
    FCID_IBGEDESTINO: String;
    FCFR_CIDADEDESTINO: String;
    FCFR_PRECOTONELADA: Double;
    FCFR_PESOCARGA: Double;
    FCFR_VALEFRETE: Double;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
    FPES_TIPOPESSOA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CFR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFR_ID', ftInteger)]
    [Dictionary('CFR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFR_ID: Integer read FCFR_ID write FCFR_ID;
    const CFR_ID_Name = 'CFR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_NOME', ftString, 100)]
    [Dictionary('TRP_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRP_NOME: String read FTRP_NOME write FTRP_NOME;
    const TRP_NOME_Name = 'TRP_NOME';

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
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CFR_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFR_DATALANCAMENTO: TDateTime read FCFR_DATALANCAMENTO write FCFR_DATALANCAMENTO;
    const CFR_DATALANCAMENTO_Name = 'CFR_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFR_CARTAFRETE', ftString, 6)]
    [Dictionary('CFR_CARTAFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CARTAFRETE: String read FCFR_CARTAFRETE write FCFR_CARTAFRETE;
    const CFR_CARTAFRETE_Name = 'CFR_CARTAFRETE';

    [Restrictions([NoValidate])]
    [Column('CFR_NOTAFISCAL', ftString, 300)]
    [Dictionary('CFR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_NOTAFISCAL: String read FCFR_NOTAFISCAL write FCFR_NOTAFISCAL;
    const CFR_NOTAFISCAL_Name = 'CFR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CFR_CONHECIMENTO', ftString, 300)]
    [Dictionary('CFR_CONHECIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CONHECIMENTO: String read FCFR_CONHECIMENTO write FCFR_CONHECIMENTO;
    const CFR_CONHECIMENTO_Name = 'CFR_CONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftString, 7)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEORIGEM: String read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CFR_CIDADEORIGEM', ftString, 100)]
    [Dictionary('CFR_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CIDADEORIGEM: String read FCFR_CIDADEORIGEM write FCFR_CIDADEORIGEM;
    const CFR_CIDADEORIGEM_Name = 'CFR_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftString, 7)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEDESTINO: String read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CFR_CIDADEDESTINO', ftString, 100)]
    [Dictionary('CFR_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CIDADEDESTINO: String read FCFR_CIDADEDESTINO write FCFR_CIDADEDESTINO;
    const CFR_CIDADEDESTINO_Name = 'CFR_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CFR_PRECOTONELADA', ftBCD)]
    [Dictionary('CFR_PRECOTONELADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_PRECOTONELADA: Double read FCFR_PRECOTONELADA write FCFR_PRECOTONELADA;
    const CFR_PRECOTONELADA_Name = 'CFR_PRECOTONELADA';

    [Restrictions([NoValidate])]
    [Column('CFR_PESOCARGA', ftBCD)]
    [Dictionary('CFR_PESOCARGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_PESOCARGA: Double read FCFR_PESOCARGA write FCFR_PESOCARGA;
    const CFR_PESOCARGA_Name = 'CFR_PESOCARGA';

    [Restrictions([NoValidate])]
    [Column('CFR_VALEFRETE', ftBCD)]
    [Dictionary('CFR_VALEFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_VALEFRETE: Double read FCFR_VALEFRETE write FCFR_VALEFRETE;
    const CFR_VALEFRETE_Name = 'CFR_VALEFRETE';

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
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA: String read FPES_PONTOREFERENCIA write FPES_PONTOREFERENCIA;
    const PES_PONTOREFERENCIA_Name = 'PES_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

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
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CFR)

end.
