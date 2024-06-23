unit express.dbo.XML_MANIFESTOCARGA;

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
  [Table('XML_MANIFESTOCARGA', '')]
  TDtoXML_MANIFESTOCARGA = class
  private
    { Private declarations } 
    FMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FMNF_CODIGO: String;
    FMF_DATASAIDA: TDateTime;
    FMF_DATARETORNO: TDateTime;
    FMF_NOTAFISCAL: String;
    FMF_SERIE: String;
    FMF_NUMEROCIOT: String;
    FMF_TOTALADIANTAMENTO: Double;
    FMF_TOTALFRETECIF: Double;
    FMF_TOTALFRETEFOB: Double;
    FMF_TOTALFRETEOUTROS: Double;
    FMF_TOTALFRETETRP: Double;
    FMF_TOTALKM: Double;
    FMF_TOTALNOTAFISCAL: Double;
    FMF_TOTALQTDCONHECIMENTO: Integer;
    FMF_TOTALQTDNOTAFISCAL: Integer;
    FMF_TOTALPESOBRUTO: Double;
    FMF_OBSERVACAO: String;
    FMF_UFORIGEM: String;
    FMF_UFDESTINO: String;
    FCID_IBGE: String;
    FCID_NOME: String;
    FPES_TIPOPESSOA_TRP: String;
    FPES_CNPJ_CPF_TRP: String;
    FPES_IE_TRP: String;
    FPES_NOME_TRP: String;
    FPES_FANTASIA_OU_APELIDO_TRP: String;
    FPES_ENDERECO_TRP: String;
    FPES_NUMEROENDERECO_TRP: String;
    FPES_BAIRRO_TRP: String;
    FPES_PONTOREFERENCIA_TRP: String;
    FPES_DDD_TELEFONE_1_TRP: String;
    FPES_EMAIL_TRP: String;
    FPES_CODIGOPAIS_TRP: String;
    FPES_PAIS_TRP: String;
    FCEP_CODIGO_TRP: String;
    FPES_UF_TRP: String;
    FVEI_CODIGO: Integer;
    FVEI_PLACAVEICULO: String;
    FVEI_UF: String;
    FVEI_RNTRC: String;
    FVEI_CAPACIDADEM3: Double;
    FVEI_CAPACIDADEKG: Double;
    FVEI_TARAKG: Double;
    FVEI_TIPORODADO: String;
    FVEI_TIPOCARROCERIA: String;
    FPES_PROPRITARIO_VEI: Integer;
    FPES_TIPOPESSOA_PROPRITARIO_VEI: String;
    FPES_NOME_PROPRITARIO_VEI: String;
    FPES_CNPJ_CPF_PROPRITARIO_VEI: String;
    FPES_IE_RG_PROPRITARIO_VEI: String;
    FCEP_CODIGO_PROPRITARIO_VEI: String;
    FCID_IBGE_PROPRITARIO_VEI: String;
    FPES_CIDADE_PROPRITARIO_VEI: String;
    FPES_UF_PROPRITARIO_VEI: String;
    FPES_ENDERECO_PROPRITARIO_VEI: String;
    FPES_NUMEROENDERECO_PROPRITARIO_VEI: String;
    FPES_BAIRRO_PROPRITARIO_VEI: String;
    FPES_DDD_TELEFONE_1_PROPRITARIO_VEI: String;
    FMF_INTEGRACAOLIVRO: String;
    FMFC_RESPONSAVELSEGURO: String;
    FMFC_CNPJCPF_RESPONSAVELSEGURO: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FCLF_CODIGO: String;
    FPRO_CODIGOBARRA: String;
    FMFC_TIPOPRODUTO: String;
    FMFC_TIPOCARGA: String;
    FMFC_LATITUDECARREGA: Double;
    FMFC_LONGITUDECARREGA: Double;
    FMFC_LATITUDEDESCARREGA: Double;
    FMFC_LONGITUDEDESCARREGA: Double;
    FPES_FORNECEDORVALEPEDAGIO: String;
    FFOR_CNPJ_CPF: String;
    FPAG_CNPJ_CPF: String;
    FMFC_NUMEROCOMPRAVALEPEDAGIO: String;
    FMFC_VALORVALEPEDAGIO: Double;
    FMFC_TIPOEMITENTEMDFE: String;
    FMFC_CATEGORIACOMBVEICULAR: String;
  public 
    { Public declarations } 
     const Table      = 'XML_MANIFESTOCARGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_ID', ftInteger)]
    [Dictionary('MF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MF_ID: Integer read FMF_ID write FMF_ID;
    const MF_ID_Name = 'MF_ID';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_DATASAIDA', ftDateTime)]
    [Dictionary('MF_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MF_DATASAIDA: TDateTime read FMF_DATASAIDA write FMF_DATASAIDA;
    const MF_DATASAIDA_Name = 'MF_DATASAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_DATARETORNO', ftDateTime)]
    [Dictionary('MF_DATARETORNO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MF_DATARETORNO: TDateTime read FMF_DATARETORNO write FMF_DATARETORNO;
    const MF_DATARETORNO_Name = 'MF_DATARETORNO';

    [Restrictions([NoValidate])]
    [Column('MF_NOTAFISCAL', ftString, 9)]
    [Dictionary('MF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_NOTAFISCAL: String read FMF_NOTAFISCAL write FMF_NOTAFISCAL;
    const MF_NOTAFISCAL_Name = 'MF_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_SERIE', ftString, 3)]
    [Dictionary('MF_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_SERIE: String read FMF_SERIE write FMF_SERIE;
    const MF_SERIE_Name = 'MF_SERIE';

    [Restrictions([NoValidate])]
    [Column('MF_NUMEROCIOT', ftString, 16)]
    [Dictionary('MF_NUMEROCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_NUMEROCIOT: String read FMF_NUMEROCIOT write FMF_NUMEROCIOT;
    const MF_NUMEROCIOT_Name = 'MF_NUMEROCIOT';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALADIANTAMENTO', ftBCD)]
    [Dictionary('MF_TOTALADIANTAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALADIANTAMENTO: Double read FMF_TOTALADIANTAMENTO write FMF_TOTALADIANTAMENTO;
    const MF_TOTALADIANTAMENTO_Name = 'MF_TOTALADIANTAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALFRETECIF', ftBCD)]
    [Dictionary('MF_TOTALFRETECIF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALFRETECIF: Double read FMF_TOTALFRETECIF write FMF_TOTALFRETECIF;
    const MF_TOTALFRETECIF_Name = 'MF_TOTALFRETECIF';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALFRETEFOB', ftBCD)]
    [Dictionary('MF_TOTALFRETEFOB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALFRETEFOB: Double read FMF_TOTALFRETEFOB write FMF_TOTALFRETEFOB;
    const MF_TOTALFRETEFOB_Name = 'MF_TOTALFRETEFOB';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALFRETEOUTROS', ftBCD, 48, 2)]
    [Dictionary('MF_TOTALFRETEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALFRETEOUTROS: Double read FMF_TOTALFRETEOUTROS write FMF_TOTALFRETEOUTROS;
    const MF_TOTALFRETEOUTROS_Name = 'MF_TOTALFRETEOUTROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALFRETETRP', ftBCD)]
    [Dictionary('MF_TOTALFRETETRP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALFRETETRP: Double read FMF_TOTALFRETETRP write FMF_TOTALFRETETRP;
    const MF_TOTALFRETETRP_Name = 'MF_TOTALFRETETRP';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALKM', ftBCD)]
    [Dictionary('MF_TOTALKM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALKM: Double read FMF_TOTALKM write FMF_TOTALKM;
    const MF_TOTALKM_Name = 'MF_TOTALKM';

    [Restrictions([NoValidate, NotNull])]
    [Column('MF_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('MF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALNOTAFISCAL: Double read FMF_TOTALNOTAFISCAL write FMF_TOTALNOTAFISCAL;
    const MF_TOTALNOTAFISCAL_Name = 'MF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MF_TOTALQTDCONHECIMENTO', ftInteger)]
    [Dictionary('MF_TOTALQTDCONHECIMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MF_TOTALQTDCONHECIMENTO: Integer read FMF_TOTALQTDCONHECIMENTO write FMF_TOTALQTDCONHECIMENTO;
    const MF_TOTALQTDCONHECIMENTO_Name = 'MF_TOTALQTDCONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('MF_TOTALQTDNOTAFISCAL', ftInteger)]
    [Dictionary('MF_TOTALQTDNOTAFISCAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property MF_TOTALQTDNOTAFISCAL: Integer read FMF_TOTALQTDNOTAFISCAL write FMF_TOTALQTDNOTAFISCAL;
    const MF_TOTALQTDNOTAFISCAL_Name = 'MF_TOTALQTDNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MF_TOTALPESOBRUTO', ftBCD)]
    [Dictionary('MF_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MF_TOTALPESOBRUTO: Double read FMF_TOTALPESOBRUTO write FMF_TOTALPESOBRUTO;
    const MF_TOTALPESOBRUTO_Name = 'MF_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('MF_OBSERVACAO', ftString, 300)]
    [Dictionary('MF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_OBSERVACAO: String read FMF_OBSERVACAO write FMF_OBSERVACAO;
    const MF_OBSERVACAO_Name = 'MF_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('MF_UFORIGEM', ftString, 2)]
    [Dictionary('MF_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_UFORIGEM: String read FMF_UFORIGEM write FMF_UFORIGEM;
    const MF_UFORIGEM_Name = 'MF_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('MF_UFDESTINO', ftString, 2)]
    [Dictionary('MF_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_UFDESTINO: String read FMF_UFDESTINO write FMF_UFDESTINO;
    const MF_UFDESTINO_Name = 'MF_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('CID_NOME', ftString, 100)]
    [Dictionary('CID_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_NOME: String read FCID_NOME write FCID_NOME;
    const CID_NOME_Name = 'CID_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_TRP', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_TRP: String read FPES_TIPOPESSOA_TRP write FPES_TIPOPESSOA_TRP;
    const PES_TIPOPESSOA_TRP_Name = 'PES_TIPOPESSOA_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_TRP', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_TRP: String read FPES_CNPJ_CPF_TRP write FPES_CNPJ_CPF_TRP;
    const PES_CNPJ_CPF_TRP_Name = 'PES_CNPJ_CPF_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_IE_TRP', ftString, 16)]
    [Dictionary('PES_IE_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_TRP: String read FPES_IE_TRP write FPES_IE_TRP;
    const PES_IE_TRP_Name = 'PES_IE_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_TRP', ftString, 100)]
    [Dictionary('PES_NOME_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_TRP: String read FPES_NOME_TRP write FPES_NOME_TRP;
    const PES_NOME_TRP_Name = 'PES_NOME_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO_TRP', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO_TRP: String read FPES_FANTASIA_OU_APELIDO_TRP write FPES_FANTASIA_OU_APELIDO_TRP;
    const PES_FANTASIA_OU_APELIDO_TRP_Name = 'PES_FANTASIA_OU_APELIDO_TRP';

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
    [Column('PES_PONTOREFERENCIA_TRP', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA_TRP: String read FPES_PONTOREFERENCIA_TRP write FPES_PONTOREFERENCIA_TRP;
    const PES_PONTOREFERENCIA_TRP_Name = 'PES_PONTOREFERENCIA_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1_TRP', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1_TRP: String read FPES_DDD_TELEFONE_1_TRP write FPES_DDD_TELEFONE_1_TRP;
    const PES_DDD_TELEFONE_1_TRP_Name = 'PES_DDD_TELEFONE_1_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_EMAIL_TRP', ftString, 300)]
    [Dictionary('PES_EMAIL_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAIL_TRP: String read FPES_EMAIL_TRP write FPES_EMAIL_TRP;
    const PES_EMAIL_TRP_Name = 'PES_EMAIL_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOPAIS_TRP', ftString, 4)]
    [Dictionary('PES_CODIGOPAIS_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CODIGOPAIS_TRP: String read FPES_CODIGOPAIS_TRP write FPES_CODIGOPAIS_TRP;
    const PES_CODIGOPAIS_TRP_Name = 'PES_CODIGOPAIS_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_PAIS_TRP', ftString, 100)]
    [Dictionary('PES_PAIS_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAIS_TRP: String read FPES_PAIS_TRP write FPES_PAIS_TRP;
    const PES_PAIS_TRP_Name = 'PES_PAIS_TRP';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO_TRP', ftString, 8)]
    [Dictionary('CEP_CODIGO_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO_TRP: String read FCEP_CODIGO_TRP write FCEP_CODIGO_TRP;
    const CEP_CODIGO_TRP_Name = 'CEP_CODIGO_TRP';

    [Restrictions([NoValidate])]
    [Column('PES_UF_TRP', ftString, 2)]
    [Dictionary('PES_UF_TRP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_TRP: String read FPES_UF_TRP write FPES_UF_TRP;
    const PES_UF_TRP_Name = 'PES_UF_TRP';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACAVEICULO', ftString, 7)]
    [Dictionary('VEI_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACAVEICULO: String read FVEI_PLACAVEICULO write FVEI_PLACAVEICULO;
    const VEI_PLACAVEICULO_Name = 'VEI_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('VEI_UF', ftString, 2)]
    [Dictionary('VEI_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_UF: String read FVEI_UF write FVEI_UF;
    const VEI_UF_Name = 'VEI_UF';

    [Restrictions([NoValidate])]
    [Column('VEI_RNTRC', ftString, 14)]
    [Dictionary('VEI_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_RNTRC: String read FVEI_RNTRC write FVEI_RNTRC;
    const VEI_RNTRC_Name = 'VEI_RNTRC';

    [Restrictions([NoValidate])]
    [Column('VEI_CAPACIDADEM3', ftBCD)]
    [Dictionary('VEI_CAPACIDADEM3', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_CAPACIDADEM3: Double read FVEI_CAPACIDADEM3 write FVEI_CAPACIDADEM3;
    const VEI_CAPACIDADEM3_Name = 'VEI_CAPACIDADEM3';

    [Restrictions([NoValidate])]
    [Column('VEI_CAPACIDADEKG', ftBCD)]
    [Dictionary('VEI_CAPACIDADEKG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_CAPACIDADEKG: Double read FVEI_CAPACIDADEKG write FVEI_CAPACIDADEKG;
    const VEI_CAPACIDADEKG_Name = 'VEI_CAPACIDADEKG';

    [Restrictions([NoValidate])]
    [Column('VEI_TARAKG', ftBCD)]
    [Dictionary('VEI_TARAKG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_TARAKG: Double read FVEI_TARAKG write FVEI_TARAKG;
    const VEI_TARAKG_Name = 'VEI_TARAKG';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPORODADO', ftString, 2)]
    [Dictionary('VEI_TIPORODADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPORODADO: String read FVEI_TIPORODADO write FVEI_TIPORODADO;
    const VEI_TIPORODADO_Name = 'VEI_TIPORODADO';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPOCARROCERIA', ftString, 2)]
    [Dictionary('VEI_TIPOCARROCERIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPOCARROCERIA: String read FVEI_TIPOCARROCERIA write FVEI_TIPOCARROCERIA;
    const VEI_TIPOCARROCERIA_Name = 'VEI_TIPOCARROCERIA';

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
    [Column('PES_IE_RG_PROPRITARIO_VEI', ftString, 16)]
    [Dictionary('PES_IE_RG_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_RG_PROPRITARIO_VEI: String read FPES_IE_RG_PROPRITARIO_VEI write FPES_IE_RG_PROPRITARIO_VEI;
    const PES_IE_RG_PROPRITARIO_VEI_Name = 'PES_IE_RG_PROPRITARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO_PROPRITARIO_VEI', ftString, 8)]
    [Dictionary('CEP_CODIGO_PROPRITARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO_PROPRITARIO_VEI: String read FCEP_CODIGO_PROPRITARIO_VEI write FCEP_CODIGO_PROPRITARIO_VEI;
    const CEP_CODIGO_PROPRITARIO_VEI_Name = 'CEP_CODIGO_PROPRITARIO_VEI';

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

    [Restrictions([NoValidate])]
    [Column('MF_INTEGRACAOLIVRO', ftString, 33)]
    [Dictionary('MF_INTEGRACAOLIVRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MF_INTEGRACAOLIVRO: String read FMF_INTEGRACAOLIVRO write FMF_INTEGRACAOLIVRO;
    const MF_INTEGRACAOLIVRO_Name = 'MF_INTEGRACAOLIVRO';

    [Restrictions([NoValidate])]
    [Column('MFC_RESPONSAVELSEGURO', ftString, 1)]
    [Dictionary('MFC_RESPONSAVELSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_RESPONSAVELSEGURO: String read FMFC_RESPONSAVELSEGURO write FMFC_RESPONSAVELSEGURO;
    const MFC_RESPONSAVELSEGURO_Name = 'MFC_RESPONSAVELSEGURO';

    [Restrictions([NoValidate])]
    [Column('MFC_CNPJCPF_RESPONSAVELSEGURO', ftString, 14)]
    [Dictionary('MFC_CNPJCPF_RESPONSAVELSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CNPJCPF_RESPONSAVELSEGURO: String read FMFC_CNPJCPF_RESPONSAVELSEGURO write FMFC_CNPJCPF_RESPONSAVELSEGURO;
    const MFC_CNPJCPF_RESPONSAVELSEGURO_Name = 'MFC_CNPJCPF_RESPONSAVELSEGURO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA: String read FPRO_CODIGOBARRA write FPRO_CODIGOBARRA;
    const PRO_CODIGOBARRA_Name = 'PRO_CODIGOBARRA';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOPRODUTO', ftString, 2)]
    [Dictionary('MFC_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOPRODUTO: String read FMFC_TIPOPRODUTO write FMFC_TIPOPRODUTO;
    const MFC_TIPOPRODUTO_Name = 'MFC_TIPOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOCARGA', ftString, 1)]
    [Dictionary('MFC_TIPOCARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOCARGA: String read FMFC_TIPOCARGA write FMFC_TIPOCARGA;
    const MFC_TIPOCARGA_Name = 'MFC_TIPOCARGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LATITUDECARREGA', ftBCD)]
    [Dictionary('MFC_LATITUDECARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LATITUDECARREGA: Double read FMFC_LATITUDECARREGA write FMFC_LATITUDECARREGA;
    const MFC_LATITUDECARREGA_Name = 'MFC_LATITUDECARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LONGITUDECARREGA', ftBCD)]
    [Dictionary('MFC_LONGITUDECARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LONGITUDECARREGA: Double read FMFC_LONGITUDECARREGA write FMFC_LONGITUDECARREGA;
    const MFC_LONGITUDECARREGA_Name = 'MFC_LONGITUDECARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LATITUDEDESCARREGA', ftBCD)]
    [Dictionary('MFC_LATITUDEDESCARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LATITUDEDESCARREGA: Double read FMFC_LATITUDEDESCARREGA write FMFC_LATITUDEDESCARREGA;
    const MFC_LATITUDEDESCARREGA_Name = 'MFC_LATITUDEDESCARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LONGITUDEDESCARREGA', ftBCD)]
    [Dictionary('MFC_LONGITUDEDESCARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LONGITUDEDESCARREGA: Double read FMFC_LONGITUDEDESCARREGA write FMFC_LONGITUDEDESCARREGA;
    const MFC_LONGITUDEDESCARREGA_Name = 'MFC_LONGITUDEDESCARREGA';

    [Restrictions([NoValidate])]
    [Column('PES_FORNECEDORVALEPEDAGIO', ftString, 6)]
    [Dictionary('PES_FORNECEDORVALEPEDAGIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FORNECEDORVALEPEDAGIO: String read FPES_FORNECEDORVALEPEDAGIO write FPES_FORNECEDORVALEPEDAGIO;
    const PES_FORNECEDORVALEPEDAGIO_Name = 'PES_FORNECEDORVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('FOR_CNPJ_CPF', ftString, 14)]
    [Dictionary('FOR_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_CNPJ_CPF: String read FFOR_CNPJ_CPF write FFOR_CNPJ_CPF;
    const FOR_CNPJ_CPF_Name = 'FOR_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PAG_CNPJ_CPF', ftString, 14)]
    [Dictionary('PAG_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PAG_CNPJ_CPF: String read FPAG_CNPJ_CPF write FPAG_CNPJ_CPF;
    const PAG_CNPJ_CPF_Name = 'PAG_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMEROCOMPRAVALEPEDAGIO', ftString, 20)]
    [Dictionary('MFC_NUMEROCOMPRAVALEPEDAGIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMEROCOMPRAVALEPEDAGIO: String read FMFC_NUMEROCOMPRAVALEPEDAGIO write FMFC_NUMEROCOMPRAVALEPEDAGIO;
    const MFC_NUMEROCOMPRAVALEPEDAGIO_Name = 'MFC_NUMEROCOMPRAVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('MFC_VALORVALEPEDAGIO', ftBCD, 48, 2)]
    [Dictionary('MFC_VALORVALEPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORVALEPEDAGIO: Double read FMFC_VALORVALEPEDAGIO write FMFC_VALORVALEPEDAGIO;
    const MFC_VALORVALEPEDAGIO_Name = 'MFC_VALORVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMITENTEMDFE', ftString, 1)]
    [Dictionary('MFC_TIPOEMITENTEMDFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMITENTEMDFE: String read FMFC_TIPOEMITENTEMDFE write FMFC_TIPOEMITENTEMDFE;
    const MFC_TIPOEMITENTEMDFE_Name = 'MFC_TIPOEMITENTEMDFE';

    [Restrictions([NoValidate])]
    [Column('MFC_CATEGORIACOMBVEICULAR', ftString, 2)]
    [Dictionary('MFC_CATEGORIACOMBVEICULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CATEGORIACOMBVEICULAR: String read FMFC_CATEGORIACOMBVEICULAR write FMFC_CATEGORIACOMBVEICULAR;
    const MFC_CATEGORIACOMBVEICULAR_Name = 'MFC_CATEGORIACOMBVEICULAR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_MANIFESTOCARGA)

end.
