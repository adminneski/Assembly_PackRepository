unit express.dbo.EXP_CTR_PROCEDA;

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
  [Table('EXP_CTR_Proceda', '')]
  TDtoEXP_CTR_Proceda = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FMNF_CODIGO: String;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAENTREGA: TDateTime;
    FPES_CLIENTESELECAO: Integer;
    FTRP_CODIGO: Integer;
    FPES_NOME: String;
    FPES_CNPJ_CPF: String;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FCTR_NOTAFISCAL: String;
    FCTR_NUMERODOCTO: String;
    FCTR_CHAVEACESSO: String;
    FCTR_TIPOFRETE: String;
    FCTR_TOTALPESOLIQUIDO: Double;
    FCTR_TOTALPRESTACAO: Double;
    FCTR_TOTALFRETE: Double;
    FCTR_TOTALBASECALCULOICMS: Double;
    FCTR_PERCENTUALICMS: Double;
    FCTR_TOTALICMS: Double;
    FCTR_TOTALDESPACHO: Double;
    FCTR_TOTALPEDAGIO: Double;
    FCTR_TOTALNUMEROVOLUMES: Double;
    FCTR_TOTALNOTAFISCAL: Double;
    FCTR_NATUREZACARGA: String;
    FCTR_ESPECIEVOLUMES: String;
    FCTR_TOTALSEGURO: Double;
    FVEI_PLACA: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_NOMECLIENTEREMETENTE: String;
    FPES_CNPJ_CPF_CLIENTEREMETENTE: String;
    FPES_IE_CI_CLIENTEREMETENTE: String;
    FPES_CEP_CLIENTEREMETENTE: String;
    FPES_CIDADE_CLIENTEREMETENTE: String;
    FPES_UF_CLIENTEREMETENTE: String;
    FPES_ENDERECO_CLIENTEREMETENTE: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_TIPOPESSOA_CLIENTEDESTINATARIO: String;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_CNPJ_CPF_CLIENTEDESTINATARIO: String;
    FPES_IE_CI_CLIENTEDESTINATARIO: String;
    FPES_CEP_CLIENTEDESTINATARIO: String;
    FPES_CIDADE_CLIENTEDESTINATARIO: String;
    FPES_UF_CLIENTEDESTINATARIO: String;
    FPES_ENDERECO_CLIENTEDESTINATARIO: String;
    FPES_BAIRRO_CLIENTEDESTINATARIO: String;
    FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO: String;
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_NOMECLIENTECONSIGNATARIO: String;
    FPES_CNPJ_CPF_CLIENTECONSIGNATARIO: String;
    FPES_IE_CI_CLIENTECONSIGNATARIO: String;
    FPES_CEP_CLIENTECONSIGNATARIO: String;
    FPES_CIDADE_CLIENTECONSIGNATARIO: String;
    FPES_UF_CLIENTECONSIGNATARIO: String;
    FPES_ENDERECO_CLIENTECONSIGNATARIO: String;
    FPES_BAIRRO_CLIENTECONSIGNATARIO: String;
    FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO: String;
    FPES_CLIENTEREDESPACHO: Integer;
    FPES_NOMECLIENTEREDESPACHO: String;
    FPES_CNPJ_CPF_NOMECLIENTEREDESPACHO: String;
    FPES_IE_CI_NOMECLIENTEREDESPACHO: String;
    FPES_CEP_CLIENTEREDESPACHO: String;
    FPES_CIDADE_CLIENTEREDESPACHO: String;
    FPES_UF_CLIENTEREDESPACHO: String;
    FPES_ENDERECO_CLIENTEREDESPACHO: String;
    FPES_BAIRRO_CLIENTEREDESPACHO: String;
    FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_CTR_Proceda';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAENTREGA', ftDateTime)]
    [Dictionary('CTR_DATAENTREGA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAENTREGA: TDateTime read FCTR_DATAENTREGA write FCTR_DATAENTREGA;
    const CTR_DATAENTREGA_Name = 'CTR_DATAENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTESELECAO', ftInteger)]
    [Dictionary('PES_CLIENTESELECAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTESELECAO: Integer read FPES_CLIENTESELECAO write FPES_CLIENTESELECAO;
    const PES_CLIENTESELECAO_Name = 'PES_CLIENTESELECAO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_SUBSERIE', ftString, 2)]
    [Dictionary('CTR_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SUBSERIE: String read FCTR_SUBSERIE write FCTR_SUBSERIE;
    const CTR_SUBSERIE_Name = 'CTR_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSO: String read FCTR_CHAVEACESSO write FCTR_CHAVEACESSO;
    const CTR_CHAVEACESSO_Name = 'CTR_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TIPOFRETE', ftString, 1)]
    [Dictionary('CTR_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOFRETE: String read FCTR_TIPOFRETE write FCTR_TIPOFRETE;
    const CTR_TIPOFRETE_Name = 'CTR_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPESOLIQUIDO: Double read FCTR_TOTALPESOLIQUIDO write FCTR_TOTALPESOLIQUIDO;
    const CTR_TOTALPESOLIQUIDO_Name = 'CTR_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPRESTACAO', ftBCD)]
    [Dictionary('CTR_TOTALPRESTACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPRESTACAO: Double read FCTR_TOTALPRESTACAO write FCTR_TOTALPRESTACAO;
    const CTR_TOTALPRESTACAO_Name = 'CTR_TOTALPRESTACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALFRETE', ftBCD)]
    [Dictionary('CTR_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALFRETE: Double read FCTR_TOTALFRETE write FCTR_TOTALFRETE;
    const CTR_TOTALFRETE_Name = 'CTR_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('CTR_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBASECALCULOICMS: Double read FCTR_TOTALBASECALCULOICMS write FCTR_TOTALBASECALCULOICMS;
    const CTR_TOTALBASECALCULOICMS_Name = 'CTR_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PERCENTUALICMS', ftBCD)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALICMS', ftBCD)]
    [Dictionary('CTR_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALICMS: Double read FCTR_TOTALICMS write FCTR_TOTALICMS;
    const CTR_TOTALICMS_Name = 'CTR_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALDESPACHO', ftBCD)]
    [Dictionary('CTR_TOTALDESPACHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALDESPACHO: Double read FCTR_TOTALDESPACHO write FCTR_TOTALDESPACHO;
    const CTR_TOTALDESPACHO_Name = 'CTR_TOTALDESPACHO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPEDAGIO', ftBCD)]
    [Dictionary('CTR_TOTALPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPEDAGIO: Double read FCTR_TOTALPEDAGIO write FCTR_TOTALPEDAGIO;
    const CTR_TOTALPEDAGIO_Name = 'CTR_TOTALPEDAGIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNUMEROVOLUMES: Double read FCTR_TOTALNUMEROVOLUMES write FCTR_TOTALNUMEROVOLUMES;
    const CTR_TOTALNUMEROVOLUMES_Name = 'CTR_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNOTAFISCAL: Double read FCTR_TOTALNOTAFISCAL write FCTR_TOTALNOTAFISCAL;
    const CTR_TOTALNOTAFISCAL_Name = 'CTR_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZACARGA', ftString, 15)]
    [Dictionary('CTR_NATUREZACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZACARGA: String read FCTR_NATUREZACARGA write FCTR_NATUREZACARGA;
    const CTR_NATUREZACARGA_Name = 'CTR_NATUREZACARGA';

    [Restrictions([NoValidate])]
    [Column('CTR_ESPECIEVOLUMES', ftString, 15)]
    [Dictionary('CTR_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ESPECIEVOLUMES: String read FCTR_ESPECIEVOLUMES write FCTR_ESPECIEVOLUMES;
    const CTR_ESPECIEVOLUMES_Name = 'CTR_ESPECIEVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALSEGURO', ftBCD)]
    [Dictionary('CTR_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALSEGURO: Double read FCTR_TOTALSEGURO write FCTR_TOTALSEGURO;
    const CTR_TOTALSEGURO_Name = 'CTR_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREMETENTE: String read FPES_NOMECLIENTEREMETENTE write FPES_NOMECLIENTEREMETENTE;
    const PES_NOMECLIENTEREMETENTE_Name = 'PES_NOMECLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTEREMETENTE', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEREMETENTE: String read FPES_CNPJ_CPF_CLIENTEREMETENTE write FPES_CNPJ_CPF_CLIENTEREMETENTE;
    const PES_CNPJ_CPF_CLIENTEREMETENTE_Name = 'PES_CNPJ_CPF_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_CLIENTEREMETENTE', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTEREMETENTE: String read FPES_IE_CI_CLIENTEREMETENTE write FPES_IE_CI_CLIENTEREMETENTE;
    const PES_IE_CI_CLIENTEREMETENTE_Name = 'PES_IE_CI_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEREMETENTE', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEREMETENTE: String read FPES_CEP_CLIENTEREMETENTE write FPES_CEP_CLIENTEREMETENTE;
    const PES_CEP_CLIENTEREMETENTE_Name = 'PES_CEP_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEREMETENTE: String read FPES_CIDADE_CLIENTEREMETENTE write FPES_CIDADE_CLIENTEREMETENTE;
    const PES_CIDADE_CLIENTEREMETENTE_Name = 'PES_CIDADE_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEREMETENTE', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEREMETENTE: String read FPES_UF_CLIENTEREMETENTE write FPES_UF_CLIENTEREMETENTE;
    const PES_UF_CLIENTEREMETENTE_Name = 'PES_UF_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEREMETENTE: String read FPES_ENDERECO_CLIENTEREMETENTE write FPES_ENDERECO_CLIENTEREMETENTE;
    const PES_ENDERECO_CLIENTEREMETENTE_Name = 'PES_ENDERECO_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_CLIENTEDESTINATARIO', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_CLIENTEDESTINATARIO: String read FPES_TIPOPESSOA_CLIENTEDESTINATARIO write FPES_TIPOPESSOA_CLIENTEDESTINATARIO;
    const PES_TIPOPESSOA_CLIENTEDESTINATARIO_Name = 'PES_TIPOPESSOA_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEDESTINATARIO: String read FPES_NOMECLIENTEDESTINATARIO write FPES_NOMECLIENTEDESTINATARIO;
    const PES_NOMECLIENTEDESTINATARIO_Name = 'PES_NOMECLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTEDESTINATARIO', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTEDESTINATARIO: String read FPES_CNPJ_CPF_CLIENTEDESTINATARIO write FPES_CNPJ_CPF_CLIENTEDESTINATARIO;
    const PES_CNPJ_CPF_CLIENTEDESTINATARIO_Name = 'PES_CNPJ_CPF_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_CLIENTEDESTINATARIO', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTEDESTINATARIO: String read FPES_IE_CI_CLIENTEDESTINATARIO write FPES_IE_CI_CLIENTEDESTINATARIO;
    const PES_IE_CI_CLIENTEDESTINATARIO_Name = 'PES_IE_CI_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEDESTINATARIO', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEDESTINATARIO: String read FPES_CEP_CLIENTEDESTINATARIO write FPES_CEP_CLIENTEDESTINATARIO;
    const PES_CEP_CLIENTEDESTINATARIO_Name = 'PES_CEP_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEDESTINATARIO: String read FPES_CIDADE_CLIENTEDESTINATARIO write FPES_CIDADE_CLIENTEDESTINATARIO;
    const PES_CIDADE_CLIENTEDESTINATARIO_Name = 'PES_CIDADE_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEDESTINATARIO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEDESTINATARIO: String read FPES_UF_CLIENTEDESTINATARIO write FPES_UF_CLIENTEDESTINATARIO;
    const PES_UF_CLIENTEDESTINATARIO_Name = 'PES_UF_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEDESTINATARIO: String read FPES_ENDERECO_CLIENTEDESTINATARIO write FPES_ENDERECO_CLIENTEDESTINATARIO;
    const PES_ENDERECO_CLIENTEDESTINATARIO_Name = 'PES_ENDERECO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEDESTINATARIO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEDESTINATARIO: String read FPES_BAIRRO_CLIENTEDESTINATARIO write FPES_BAIRRO_CLIENTEDESTINATARIO;
    const PES_BAIRRO_CLIENTEDESTINATARIO_Name = 'PES_BAIRRO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO: String read FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO write FPES_DDD_TELEFONE_1_CLIENTEDESTINATARIO;
    const PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO_Name = 'PES_DDD_TELEFONE_1_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONSIGNATARIO', ftInteger)]
    [Dictionary('PES_CLIENTECONSIGNATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTECONSIGNATARIO: Integer read FPES_CLIENTECONSIGNATARIO write FPES_CLIENTECONSIGNATARIO;
    const PES_CLIENTECONSIGNATARIO_Name = 'PES_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTECONSIGNATARIO: String read FPES_NOMECLIENTECONSIGNATARIO write FPES_NOMECLIENTECONSIGNATARIO;
    const PES_NOMECLIENTECONSIGNATARIO_Name = 'PES_NOMECLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_CLIENTECONSIGNATARIO', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_CLIENTECONSIGNATARIO: String read FPES_CNPJ_CPF_CLIENTECONSIGNATARIO write FPES_CNPJ_CPF_CLIENTECONSIGNATARIO;
    const PES_CNPJ_CPF_CLIENTECONSIGNATARIO_Name = 'PES_CNPJ_CPF_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_CLIENTECONSIGNATARIO', ftString, 16)]
    [Dictionary('PES_IE_CI_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_CLIENTECONSIGNATARIO: String read FPES_IE_CI_CLIENTECONSIGNATARIO write FPES_IE_CI_CLIENTECONSIGNATARIO;
    const PES_IE_CI_CLIENTECONSIGNATARIO_Name = 'PES_IE_CI_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTECONSIGNATARIO', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTECONSIGNATARIO: String read FPES_CEP_CLIENTECONSIGNATARIO write FPES_CEP_CLIENTECONSIGNATARIO;
    const PES_CEP_CLIENTECONSIGNATARIO_Name = 'PES_CEP_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTECONSIGNATARIO: String read FPES_CIDADE_CLIENTECONSIGNATARIO write FPES_CIDADE_CLIENTECONSIGNATARIO;
    const PES_CIDADE_CLIENTECONSIGNATARIO_Name = 'PES_CIDADE_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTECONSIGNATARIO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTECONSIGNATARIO: String read FPES_UF_CLIENTECONSIGNATARIO write FPES_UF_CLIENTECONSIGNATARIO;
    const PES_UF_CLIENTECONSIGNATARIO_Name = 'PES_UF_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTECONSIGNATARIO: String read FPES_ENDERECO_CLIENTECONSIGNATARIO write FPES_ENDERECO_CLIENTECONSIGNATARIO;
    const PES_ENDERECO_CLIENTECONSIGNATARIO_Name = 'PES_ENDERECO_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTECONSIGNATARIO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTECONSIGNATARIO: String read FPES_BAIRRO_CLIENTECONSIGNATARIO write FPES_BAIRRO_CLIENTECONSIGNATARIO;
    const PES_BAIRRO_CLIENTECONSIGNATARIO_Name = 'PES_BAIRRO_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO: String read FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO write FPES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO;
    const PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO_Name = 'PES_DDD_TELEFONE_1_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREDESPACHO', ftInteger)]
    [Dictionary('PES_CLIENTEREDESPACHO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREDESPACHO: Integer read FPES_CLIENTEREDESPACHO write FPES_CLIENTEREDESPACHO;
    const PES_CLIENTEREDESPACHO_Name = 'PES_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREDESPACHO: String read FPES_NOMECLIENTEREDESPACHO write FPES_NOMECLIENTEREDESPACHO;
    const PES_NOMECLIENTEREDESPACHO_Name = 'PES_NOMECLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_NOMECLIENTEREDESPACHO', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_NOMECLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_NOMECLIENTEREDESPACHO: String read FPES_CNPJ_CPF_NOMECLIENTEREDESPACHO write FPES_CNPJ_CPF_NOMECLIENTEREDESPACHO;
    const PES_CNPJ_CPF_NOMECLIENTEREDESPACHO_Name = 'PES_CNPJ_CPF_NOMECLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_NOMECLIENTEREDESPACHO', ftString, 16)]
    [Dictionary('PES_IE_CI_NOMECLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_NOMECLIENTEREDESPACHO: String read FPES_IE_CI_NOMECLIENTEREDESPACHO write FPES_IE_CI_NOMECLIENTEREDESPACHO;
    const PES_IE_CI_NOMECLIENTEREDESPACHO_Name = 'PES_IE_CI_NOMECLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CEP_CLIENTEREDESPACHO', ftString, 8)]
    [Dictionary('PES_CEP_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEP_CLIENTEREDESPACHO: String read FPES_CEP_CLIENTEREDESPACHO write FPES_CEP_CLIENTEREDESPACHO;
    const PES_CEP_CLIENTEREDESPACHO_Name = 'PES_CEP_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE_CLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_CIDADE_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE_CLIENTEREDESPACHO: String read FPES_CIDADE_CLIENTEREDESPACHO write FPES_CIDADE_CLIENTEREDESPACHO;
    const PES_CIDADE_CLIENTEREDESPACHO_Name = 'PES_CIDADE_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEREDESPACHO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEREDESPACHO: String read FPES_UF_CLIENTEREDESPACHO write FPES_UF_CLIENTEREDESPACHO;
    const PES_UF_CLIENTEREDESPACHO_Name = 'PES_UF_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEREDESPACHO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEREDESPACHO: String read FPES_ENDERECO_CLIENTEREDESPACHO write FPES_ENDERECO_CLIENTEREDESPACHO;
    const PES_ENDERECO_CLIENTEREDESPACHO_Name = 'PES_ENDERECO_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEREDESPACHO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEREDESPACHO: String read FPES_BAIRRO_CLIENTEREDESPACHO write FPES_BAIRRO_CLIENTEREDESPACHO;
    const PES_BAIRRO_CLIENTEREDESPACHO_Name = 'PES_BAIRRO_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_CLIENTEREDESPACHO', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_CLIENTEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_CLIENTEREDESPACHO: String read FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO write FPES_DDD_TELEFONE_1_CLIENTEREDESPACHO;
    const PES_DDD_TELEFONE_1_CLIENTEREDESPACHO_Name = 'PES_DDD_TELEFONE_1_CLIENTEREDESPACHO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_CTR_Proceda)

end.
