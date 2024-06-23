unit express.dbo.EXP_NFESAIDA;

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
  [Table('EXP_NFeSaida', '')]
  TDtoEXP_NFeSaida = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNTO_DESCRICAO: String;
    FMNF_CODIGO: String;
    FLFS_SERIE: String;
    FLFS_NOTAFISCAL: String;
    FLFS_NUMEROORDEMCOMPRA: String;
    FLFS_FINALIDADE: String;
    FLFS_DATASAIDA: TDateTime;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_DATALANCAMENTO: TDateTime;
    FTRP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_TIPOPESSOA: String;
    FPES_NOME: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_PAIS: String;
    FPES_CODIGOPAIS: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FLFS_TOTALIPI: Double;
    FLFS_TOTALPIS: Double;
    FLFS_TOTALCOFINS: Double;
    FLFS_TOTALICMS: Double;
    FLFS_TOTALICMSR: Double;
    FLFS_TOTALFRETENF: Double;
    FLFS_TOTALSEGURO: Double;
    FLFS_TOTALDESCTO: Double;
    FLFS_TOTALPRODUTOS: Double;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_TOTALBASECALCULOMVA: Double;
    FLFS_TOTALBASECALCULOICMS: Double;
    FLFS_TOTALBASEISENTOICMS: Double;
    FLFS_TOTALPESOLIQUIDO: Double;
    FLFS_TOTALPESOBRUTO: Double;
    FLFS_INTEGRACAO: String;
    FLFS_TIPOFRETE: String;
    FLFS_INFCOMPLEMENTAR: String;
    FLFS_TOTALNUMEROVOLUMES: Integer;
    FLFS_NUMERACAOVOLUMES: String;
    FLFS_ESPECIEVOLUMES: String;
    FLFS_MARCAVOLUMES: String;
    FLFS_CHAVEREFERENCIANFE: TBlob;
    FLFS_TOTALDESPACESSORIA: Double;
    FLFS_PLACAVEICULO: String;
    FLFS_UFVEICULO: String;
    FLFS_TOTALISS: Double;
    FLFS_TOTALBASECALCULOISS: Double;
  public 
    { Public declarations } 
     const Table      = 'EXP_NFeSaida';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

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
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('LFS_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROORDEMCOMPRA: String read FLFS_NUMEROORDEMCOMPRA write FLFS_NUMEROORDEMCOMPRA;
    const LFS_NUMEROORDEMCOMPRA_Name = 'LFS_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate])]
    [Column('LFS_FINALIDADE', ftString, 1)]
    [Dictionary('LFS_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_FINALIDADE: String read FLFS_FINALIDADE write FLFS_FINALIDADE;
    const LFS_FINALIDADE_Name = 'LFS_FINALIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATASAIDA', ftDateTime)]
    [Dictionary('LFS_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATASAIDA: TDateTime read FLFS_DATASAIDA write FLFS_DATASAIDA;
    const LFS_DATASAIDA_Name = 'LFS_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATALANCAMENTO', ftDateTime)]
    [Dictionary('LFS_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATALANCAMENTO: TDateTime read FLFS_DATALANCAMENTO write FLFS_DATALANCAMENTO;
    const LFS_DATALANCAMENTO_Name = 'LFS_DATALANCAMENTO';

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
    [Column('LFS_TOTALIPI', ftBCD)]
    [Dictionary('LFS_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALIPI: Double read FLFS_TOTALIPI write FLFS_TOTALIPI;
    const LFS_TOTALIPI_Name = 'LFS_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALPIS', ftBCD)]
    [Dictionary('LFS_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPIS: Double read FLFS_TOTALPIS write FLFS_TOTALPIS;
    const LFS_TOTALPIS_Name = 'LFS_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALCOFINS', ftBCD)]
    [Dictionary('LFS_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOFINS: Double read FLFS_TOTALCOFINS write FLFS_TOTALCOFINS;
    const LFS_TOTALCOFINS_Name = 'LFS_TOTALCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMS', ftBCD)]
    [Dictionary('LFS_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMS: Double read FLFS_TOTALICMS write FLFS_TOTALICMS;
    const LFS_TOTALICMS_Name = 'LFS_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALICMSR', ftBCD, 48, 2)]
    [Dictionary('LFS_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALICMSR: Double read FLFS_TOTALICMSR write FLFS_TOTALICMSR;
    const LFS_TOTALICMSR_Name = 'LFS_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALFRETENF', ftBCD)]
    [Dictionary('LFS_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFRETENF: Double read FLFS_TOTALFRETENF write FLFS_TOTALFRETENF;
    const LFS_TOTALFRETENF_Name = 'LFS_TOTALFRETENF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALSEGURO', ftBCD, 48, 2)]
    [Dictionary('LFS_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSEGURO: Double read FLFS_TOTALSEGURO write FLFS_TOTALSEGURO;
    const LFS_TOTALSEGURO_Name = 'LFS_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDESCTO', ftBCD)]
    [Dictionary('LFS_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESCTO: Double read FLFS_TOTALDESCTO write FLFS_TOTALDESCTO;
    const LFS_TOTALDESCTO_Name = 'LFS_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPRODUTOS', ftBCD, 48, 2)]
    [Dictionary('LFS_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPRODUTOS: Double read FLFS_TOTALPRODUTOS write FLFS_TOTALPRODUTOS;
    const LFS_TOTALPRODUTOS_Name = 'LFS_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOMVA: Double read FLFS_TOTALBASECALCULOMVA write FLFS_TOTALBASECALCULOMVA;
    const LFS_TOTALBASECALCULOMVA_Name = 'LFS_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOICMS: Double read FLFS_TOTALBASECALCULOICMS write FLFS_TOTALBASECALCULOICMS;
    const LFS_TOTALBASECALCULOICMS_Name = 'LFS_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('LFS_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASEISENTOICMS: Double read FLFS_TOTALBASEISENTOICMS write FLFS_TOTALBASEISENTOICMS;
    const LFS_TOTALBASEISENTOICMS_Name = 'LFS_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOLIQUIDO: Double read FLFS_TOTALPESOLIQUIDO write FLFS_TOTALPESOLIQUIDO;
    const LFS_TOTALPESOLIQUIDO_Name = 'LFS_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOBRUTO: Double read FLFS_TOTALPESOBRUTO write FLFS_TOTALPESOBRUTO;
    const LFS_TOTALPESOBRUTO_Name = 'LFS_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFS_INTEGRACAO', ftString, 20)]
    [Dictionary('LFS_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INTEGRACAO: String read FLFS_INTEGRACAO write FLFS_INTEGRACAO;
    const LFS_INTEGRACAO_Name = 'LFS_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOFRETE', ftString, 1)]
    [Dictionary('LFS_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOFRETE: String read FLFS_TIPOFRETE write FLFS_TIPOFRETE;
    const LFS_TIPOFRETE_Name = 'LFS_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('LFS_INFCOMPLEMENTAR', ftString, 5000)]
    [Dictionary('LFS_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INFCOMPLEMENTAR: String read FLFS_INFCOMPLEMENTAR write FLFS_INFCOMPLEMENTAR;
    const LFS_INFCOMPLEMENTAR_Name = 'LFS_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALNUMEROVOLUMES', ftInteger)]
    [Dictionary('LFS_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_TOTALNUMEROVOLUMES: Integer read FLFS_TOTALNUMEROVOLUMES write FLFS_TOTALNUMEROVOLUMES;
    const LFS_TOTALNUMEROVOLUMES_Name = 'LFS_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('LFS_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMERACAOVOLUMES: String read FLFS_NUMERACAOVOLUMES write FLFS_NUMERACAOVOLUMES;
    const LFS_NUMERACAOVOLUMES_Name = 'LFS_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('LFS_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_ESPECIEVOLUMES: String read FLFS_ESPECIEVOLUMES write FLFS_ESPECIEVOLUMES;
    const LFS_ESPECIEVOLUMES_Name = 'LFS_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_MARCAVOLUMES', ftString, 30)]
    [Dictionary('LFS_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_MARCAVOLUMES: String read FLFS_MARCAVOLUMES write FLFS_MARCAVOLUMES;
    const LFS_MARCAVOLUMES_Name = 'LFS_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEREFERENCIANFE', ftBlob)]
    [Dictionary('LFS_CHAVEREFERENCIANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEREFERENCIANFE: TBlob read FLFS_CHAVEREFERENCIANFE write FLFS_CHAVEREFERENCIANFE;
    const LFS_CHAVEREFERENCIANFE_Name = 'LFS_CHAVEREFERENCIANFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('LFS_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESPACESSORIA: Double read FLFS_TOTALDESPACESSORIA write FLFS_TOTALDESPACESSORIA;
    const LFS_TOTALDESPACESSORIA_Name = 'LFS_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('LFS_PLACAVEICULO', ftString, 7)]
    [Dictionary('LFS_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_PLACAVEICULO: String read FLFS_PLACAVEICULO write FLFS_PLACAVEICULO;
    const LFS_PLACAVEICULO_Name = 'LFS_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('LFS_UFVEICULO', ftString, 2)]
    [Dictionary('LFS_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UFVEICULO: String read FLFS_UFVEICULO write FLFS_UFVEICULO;
    const LFS_UFVEICULO_Name = 'LFS_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALISS', ftBCD)]
    [Dictionary('LFS_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALISS: Double read FLFS_TOTALISS write FLFS_TOTALISS;
    const LFS_TOTALISS_Name = 'LFS_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOISS: Double read FLFS_TOTALBASECALCULOISS write FLFS_TOTALBASECALCULOISS;
    const LFS_TOTALBASECALCULOISS_Name = 'LFS_TOTALBASECALCULOISS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_NFeSaida)

end.
