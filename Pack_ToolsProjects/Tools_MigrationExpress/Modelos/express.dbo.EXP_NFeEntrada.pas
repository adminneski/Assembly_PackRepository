unit express.dbo.EXP_NFEENTRADA;

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
  [Table('EXP_NFeEntrada', '')]
  TDtoEXP_NFeEntrada = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNTO_DESCRICAO: String;
    FMNF_CODIGO: String;
    FLFE_SERIE: String;
    FLFE_NOTAFISCAL: String;
    FLFE_FINALIDADE: String;
    FLFE_DATAEMISSAO: TDateTime;
    FLFE_DATAENTRADA: TDateTime;
    FLFE_DATALANCAMENTO: TDateTime;
    FTRP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_TIPOPESSOA: String;
    FPES_NOME: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_CIDADE: String;
    FCID_IBGE: String;
    FPES_UF: String;
    FPES_PAIS: String;
    FPES_CODIGOPAIS: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FLFE_TOTALIPI: Double;
    FLFE_TOTALPIS: Double;
    FLFE_TOTALCOFINS: Double;
    FLFE_TOTALICMS: Double;
    FLFE_TOTALICMSR: Double;
    FLFE_TOTALFRETENF: Double;
    FLFE_TOTALSEGURO: Double;
    FLFE_TOTALDESCTO: Double;
    FLFE_TOTALPRODUTOS: Double;
    FLFE_TOTALNOTAFISCAL: Double;
    FLFE_TOTALBASECALCULOMVA: Double;
    FLFE_TOTALBASECALCULOICMS: Double;
    FLFE_TOTALBASEISENTOICMS: Double;
    FLFE_TOTALPESOLIQUIDO: Double;
    FLFE_TOTALPESOBRUTO: Double;
    FLFE_INTEGRACAO: String;
    FLFE_TIPOFRETE: String;
    FLFE_INFCOMPLEMENTAR: String;
    FLFE_TOTALNUMEROVOLUMES: Integer;
    FLFE_NUMERACAOVOLUMES: String;
    FLFE_ESPECIEVOLUMES: String;
    FLFE_MARCAVOLUMES: String;
    FLFE_CHAVEREFERENCIANFE: TBlob;
    FLFE_TOTALDESPACESSORIA: Double;
    FLFE_PLACAVEICULO: String;
    FLFE_UFVEICULO: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_NFeEntrada';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_SERIE', ftString, 3)]
    [Dictionary('LFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_SERIE: String read FLFE_SERIE write FLFE_SERIE;
    const LFE_SERIE_Name = 'LFE_SERIE';

    [Restrictions([NoValidate])]
    [Column('LFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NOTAFISCAL: String read FLFE_NOTAFISCAL write FLFE_NOTAFISCAL;
    const LFE_NOTAFISCAL_Name = 'LFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_FINALIDADE', ftString, 1)]
    [Dictionary('LFE_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_FINALIDADE: String read FLFE_FINALIDADE write FLFE_FINALIDADE;
    const LFE_FINALIDADE_Name = 'LFE_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('LFE_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFE_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFE_DATAEMISSAO: TDateTime read FLFE_DATAEMISSAO write FLFE_DATAEMISSAO;
    const LFE_DATAEMISSAO_Name = 'LFE_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAENTRADA', ftDateTime)]
    [Dictionary('LFE_DATAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAENTRADA: TDateTime read FLFE_DATAENTRADA write FLFE_DATAENTRADA;
    const LFE_DATAENTRADA_Name = 'LFE_DATAENTRADA';

    [Restrictions([NoValidate])]
    [Column('LFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('LFE_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFE_DATALANCAMENTO: TDateTime read FLFE_DATALANCAMENTO write FLFE_DATALANCAMENTO;
    const LFE_DATALANCAMENTO_Name = 'LFE_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

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
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

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
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS', ftString, 100)]
    [Dictionary('PES_PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS: String read FPES_PAIS write FPES_PAIS;
    const PES_PAIS_Name = 'PES_PAIS';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS: String read FPES_CODIGOPAIS write FPES_CODIGOPAIS;
    const PES_CODIGOPAIS_Name = 'PES_CODIGOPAIS';

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
    [Column('LFE_TOTALIPI', ftBCD)]
    [Dictionary('LFE_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALIPI: Double read FLFE_TOTALIPI write FLFE_TOTALIPI;
    const LFE_TOTALIPI_Name = 'LFE_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALPIS', ftBCD, 48, 2)]
    [Dictionary('LFE_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPIS: Double read FLFE_TOTALPIS write FLFE_TOTALPIS;
    const LFE_TOTALPIS_Name = 'LFE_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALCOFINS', ftBCD)]
    [Dictionary('LFE_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALCOFINS: Double read FLFE_TOTALCOFINS write FLFE_TOTALCOFINS;
    const LFE_TOTALCOFINS_Name = 'LFE_TOTALCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALICMS', ftBCD)]
    [Dictionary('LFE_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALICMS: Double read FLFE_TOTALICMS write FLFE_TOTALICMS;
    const LFE_TOTALICMS_Name = 'LFE_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALICMSR', ftBCD)]
    [Dictionary('LFE_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALICMSR: Double read FLFE_TOTALICMSR write FLFE_TOTALICMSR;
    const LFE_TOTALICMSR_Name = 'LFE_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALFRETENF', ftBCD)]
    [Dictionary('LFE_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALFRETENF: Double read FLFE_TOTALFRETENF write FLFE_TOTALFRETENF;
    const LFE_TOTALFRETENF_Name = 'LFE_TOTALFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALSEGURO', ftBCD)]
    [Dictionary('LFE_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALSEGURO: Double read FLFE_TOTALSEGURO write FLFE_TOTALSEGURO;
    const LFE_TOTALSEGURO_Name = 'LFE_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALDESCTO', ftBCD)]
    [Dictionary('LFE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESCTO: Double read FLFE_TOTALDESCTO write FLFE_TOTALDESCTO;
    const LFE_TOTALDESCTO_Name = 'LFE_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPRODUTOS', ftBCD)]
    [Dictionary('LFE_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPRODUTOS: Double read FLFE_TOTALPRODUTOS write FLFE_TOTALPRODUTOS;
    const LFE_TOTALPRODUTOS_Name = 'LFE_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALNOTAFISCAL: Double read FLFE_TOTALNOTAFISCAL write FLFE_TOTALNOTAFISCAL;
    const LFE_TOTALNOTAFISCAL_Name = 'LFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOMVA: Double read FLFE_TOTALBASECALCULOMVA write FLFE_TOTALBASECALCULOMVA;
    const LFE_TOTALBASECALCULOMVA_Name = 'LFE_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('LFE_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASECALCULOICMS: Double read FLFE_TOTALBASECALCULOICMS write FLFE_TOTALBASECALCULOICMS;
    const LFE_TOTALBASECALCULOICMS_Name = 'LFE_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('LFE_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASEISENTOICMS: Double read FLFE_TOTALBASEISENTOICMS write FLFE_TOTALBASEISENTOICMS;
    const LFE_TOTALBASEISENTOICMS_Name = 'LFE_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFE_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPESOLIQUIDO: Double read FLFE_TOTALPESOLIQUIDO write FLFE_TOTALPESOLIQUIDO;
    const LFE_TOTALPESOLIQUIDO_Name = 'LFE_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFE_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPESOBRUTO: Double read FLFE_TOTALPESOBRUTO write FLFE_TOTALPESOBRUTO;
    const LFE_TOTALPESOBRUTO_Name = 'LFE_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFE_INTEGRACAO', ftString, 20)]
    [Dictionary('LFE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_INTEGRACAO: String read FLFE_INTEGRACAO write FLFE_INTEGRACAO;
    const LFE_INTEGRACAO_Name = 'LFE_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('LFE_TIPOFRETE', ftString, 1)]
    [Dictionary('LFE_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_TIPOFRETE: String read FLFE_TIPOFRETE write FLFE_TIPOFRETE;
    const LFE_TIPOFRETE_Name = 'LFE_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('LFE_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('LFE_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_INFCOMPLEMENTAR: String read FLFE_INFCOMPLEMENTAR write FLFE_INFCOMPLEMENTAR;
    const LFE_INFCOMPLEMENTAR_Name = 'LFE_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('LFE_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_TOTALNUMEROVOLUMES: Integer read FLFE_TOTALNUMEROVOLUMES write FLFE_TOTALNUMEROVOLUMES;
    const LFE_TOTALNUMEROVOLUMES_Name = 'LFE_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('LFE_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NUMERACAOVOLUMES: String read FLFE_NUMERACAOVOLUMES write FLFE_NUMERACAOVOLUMES;
    const LFE_NUMERACAOVOLUMES_Name = 'LFE_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('LFE_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_ESPECIEVOLUMES: String read FLFE_ESPECIEVOLUMES write FLFE_ESPECIEVOLUMES;
    const LFE_ESPECIEVOLUMES_Name = 'LFE_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_MARCAVOLUMES', ftString, 30)]
    [Dictionary('LFE_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_MARCAVOLUMES: String read FLFE_MARCAVOLUMES write FLFE_MARCAVOLUMES;
    const LFE_MARCAVOLUMES_Name = 'LFE_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFE_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('LFE_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CHAVEREFERENCIANFE: TBlob read FLFE_CHAVEREFERENCIANFE write FLFE_CHAVEREFERENCIANFE;
    const LFE_CHAVEREFERENCIANFE_Name = 'LFE_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALDESPACESSORIA', ftBCD, 10, 2)]
    [Dictionary('LFE_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALDESPACESSORIA: Double read FLFE_TOTALDESPACESSORIA write FLFE_TOTALDESPACESSORIA;
    const LFE_TOTALDESPACESSORIA_Name = 'LFE_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('LFE_PLACAVEICULO', ftString, 7)]
    [Dictionary('LFE_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_PLACAVEICULO: String read FLFE_PLACAVEICULO write FLFE_PLACAVEICULO;
    const LFE_PLACAVEICULO_Name = 'LFE_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('LFE_UFVEICULO', ftString, 2)]
    [Dictionary('LFE_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_UFVEICULO: String read FLFE_UFVEICULO write FLFE_UFVEICULO;
    const LFE_UFVEICULO_Name = 'LFE_UFVEICULO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_NFeEntrada)

end.
