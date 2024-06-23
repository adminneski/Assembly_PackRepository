unit express.dbo.CONFIG_00_03;

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
  [Table('CONFIG_00_03', '')]
  [PrimaryKey('CFG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFG_CODIGO')]
  TDtoCONFIG_00_03 = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FNFE_FINALIDADE: String;
    FNFE_TIPOEMISSAO: String;
    FNFE_AMBIENTEENVIO: String;
    FNFE_PATHEXPORTACAO: String;
    FNFE_PATHIMPORTACAO: String;
    FMNF_CODIGOPADRAOSAIDA: String;
    FMNF_CODIGOPADRAOENTRADA: String;
    FCFG_PERCENTUALCDICMSSIMPLES: Double;
    FNFE_SERIENFE: String;
    FNFE_SERIENFECONTIGENCIA: String;
    FNFE_ESPECIE: String;
    FNFE_MARCA: String;
    FCFG_DATAALTERACAO: TDateTime;
    FNFE_TIPODANFE: String;
    FNFE_CERTIFICADONUMEROSERIE: String;
    FNFE_CERTIFICADOSENHA: String;
    FNFE_UFDESTINO: String;
    FNFE_PROXYHOST: String;
    FNFE_PROXYPORTA: Integer;
    FNFE_PROXYUSUARIO: String;
    FNFE_PROXYSENHA: String;
    FNFE_PATHLOGOMARCA: String;
    FNFE_PATHSCHEMA: String;
    FNFE_PATHREPOSITORIO: String;
    FNFE_PATHARQENVIORESPOSTA: String;
    FNFE_ATUALIZARNOTASINICIAR: String;
    FNFE_ENVIAREMAILAPOSAUTORIZACAO: String;
    FNFE_TIPODESCRICAOPRODUTO: String;
    FNFE_MENSAGEMRODAPENOTASAIDA: String;
    FNFE_MENSAGEMRODAPENOTAENTRADA: String;
    FNFE_EMAILSERVIDORENVIO: String;
    FNFE_EMAILENVIO: String;
    FNFE_EMAILUSUARIOENVIO: String;
    FNFE_EMAILSENHAENVIO: String;
    FNFE_EMAILPORTAENVIO: Integer;
    FNFE_EMAILSSL: String;
    FNFE_ORDEMIMPRESSAOITENS: String;
    FNFE_SSLLIB: String;
    FMNF_CODIGOPADRAONFC: String;
    FNFE_SERIENFC: String;
    FNFE_CODIGOCSC: String;
    FNFE_MOTIVOCONTIGENCIA: String;
    FNFE_CODIGOIDCSC: Integer;
    FNFE_IMPRIMENOTAPROMISSORIANFCE: String;
    FMNF_CODIGOPADRAOSERVICO: String;
    FNFSE_SERIESERVICO: String;
    FNFSE_AMBIENTEENVIO: String;
    FNFSE_CERTIFICADONUMEROSERIE: String;
    FNFSE_CERTIFICADOSENHA: String;
    FNFSE_SSLLIB: String;
    FNFSE_IBGECIDADE: String;
    FNFSE_PROXYHOST: String;
    FNFSE_PROXYPORTA: Integer;
    FNFSE_PROXYUSUARIO: String;
    FNFSE_PROXYSENHA: String;
    FNFSE_PATHLOGOMARCA: String;
    FNFSE_PATHLOGOMARCAPREFEITURA: String;
    FNFSE_PATHSCHEMAPROVEDOR: String;
    FNFSE_PATHREPOSITORIO: String;
    FNFSE_PATHARQENVIORESPOSTA: String;
    FNFSE_PATHARQUIVOINI: String;
    FNFSE_ATUALIZARNOTASINICIAR: String;
    FNFSE_ENVIAREMAILAPOSAUTORIZACAO: String;
    FNFSE_WEBUSUARIO: String;
    FNFSE_WEBSENHA: String;
    FNFSE_WEBFRASESECRETA: String;
    FNFSE_REGIMETRIBUTACAO: Integer;
    FNFSE_INCENTIVADORCULTURAL: String;
    FNFSE_CIDADE: String;
    FNFE_ULTIMONSUMANIFESTACAO: Integer;
    FNFSE_VALORMINRETENCAOFEDERAL: Double;
    FNFSE_VALORMINRETENCAOIR: Double;
    FNFE_CNPJSEFAZUFEMITENTE: String;
    FNFE_EMAILTLS: String;
    FNFE_DADOSCERTIFICADO_A1PFX: TBlob;
  public 
    { Public declarations } 
     const Table      = 'CONFIG_00_03';
     const PrimaryKey = 'CFG_CODIGO';
     const Sequence   = 'SEQ_CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_FINALIDADE', ftString, 1)]
    [Dictionary('NFE_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_FINALIDADE: String read FNFE_FINALIDADE write FNFE_FINALIDADE;
    const NFE_FINALIDADE_Name = 'NFE_FINALIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TIPOEMISSAO', ftString, 1)]
    [Dictionary('NFE_TIPOEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOEMISSAO: String read FNFE_TIPOEMISSAO write FNFE_TIPOEMISSAO;
    const NFE_TIPOEMISSAO_Name = 'NFE_TIPOEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('NFE_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_AMBIENTEENVIO: String read FNFE_AMBIENTEENVIO write FNFE_AMBIENTEENVIO;
    const NFE_AMBIENTEENVIO_Name = 'NFE_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHEXPORTACAO', ftString, 600)]
    [Dictionary('NFE_PATHEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHEXPORTACAO: String read FNFE_PATHEXPORTACAO write FNFE_PATHEXPORTACAO;
    const NFE_PATHEXPORTACAO_Name = 'NFE_PATHEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHIMPORTACAO', ftString, 255)]
    [Dictionary('NFE_PATHIMPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHIMPORTACAO: String read FNFE_PATHIMPORTACAO write FNFE_PATHIMPORTACAO;
    const NFE_PATHIMPORTACAO_Name = 'NFE_PATHIMPORTACAO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAOSAIDA', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAOSAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAOSAIDA: String read FMNF_CODIGOPADRAOSAIDA write FMNF_CODIGOPADRAOSAIDA;
    const MNF_CODIGOPADRAOSAIDA_Name = 'MNF_CODIGOPADRAOSAIDA';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAOENTRADA', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAOENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAOENTRADA: String read FMNF_CODIGOPADRAOENTRADA write FMNF_CODIGOPADRAOENTRADA;
    const MNF_CODIGOPADRAOENTRADA_Name = 'MNF_CODIGOPADRAOENTRADA';

    [Restrictions([NoValidate])]
    [Column('CFG_PERCENTUALCDICMSSIMPLES', ftBCD, 18, 4)]
    [Dictionary('CFG_PERCENTUALCDICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_PERCENTUALCDICMSSIMPLES: Double read FCFG_PERCENTUALCDICMSSIMPLES write FCFG_PERCENTUALCDICMSSIMPLES;
    const CFG_PERCENTUALCDICMSSIMPLES_Name = 'CFG_PERCENTUALCDICMSSIMPLES';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIENFE', ftString, 3)]
    [Dictionary('NFE_SERIENFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIENFE: String read FNFE_SERIENFE write FNFE_SERIENFE;
    const NFE_SERIENFE_Name = 'NFE_SERIENFE';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIENFECONTIGENCIA', ftString, 3)]
    [Dictionary('NFE_SERIENFECONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIENFECONTIGENCIA: String read FNFE_SERIENFECONTIGENCIA write FNFE_SERIENFECONTIGENCIA;
    const NFE_SERIENFECONTIGENCIA_Name = 'NFE_SERIENFECONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('NFE_ESPECIE', ftString, 30)]
    [Dictionary('NFE_ESPECIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ESPECIE: String read FNFE_ESPECIE write FNFE_ESPECIE;
    const NFE_ESPECIE_Name = 'NFE_ESPECIE';

    [Restrictions([NoValidate])]
    [Column('NFE_MARCA', ftString, 30)]
    [Dictionary('NFE_MARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MARCA: String read FNFE_MARCA write FNFE_MARCA;
    const NFE_MARCA_Name = 'NFE_MARCA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPODANFE', ftString, 1)]
    [Dictionary('NFE_TIPODANFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPODANFE: String read FNFE_TIPODANFE write FNFE_TIPODANFE;
    const NFE_TIPODANFE_Name = 'NFE_TIPODANFE';

    [Restrictions([NoValidate])]
    [Column('NFE_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('NFE_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CERTIFICADONUMEROSERIE: String read FNFE_CERTIFICADONUMEROSERIE write FNFE_CERTIFICADONUMEROSERIE;
    const NFE_CERTIFICADONUMEROSERIE_Name = 'NFE_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('NFE_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('NFE_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CERTIFICADOSENHA: String read FNFE_CERTIFICADOSENHA write FNFE_CERTIFICADOSENHA;
    const NFE_CERTIFICADOSENHA_Name = 'NFE_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('NFE_UFDESTINO', ftString, 2)]
    [Dictionary('NFE_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_UFDESTINO: String read FNFE_UFDESTINO write FNFE_UFDESTINO;
    const NFE_UFDESTINO_Name = 'NFE_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYHOST', ftString, 50)]
    [Dictionary('NFE_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROXYHOST: String read FNFE_PROXYHOST write FNFE_PROXYHOST;
    const NFE_PROXYHOST_Name = 'NFE_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYPORTA', ftInteger)]
    [Dictionary('NFE_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_PROXYPORTA: Integer read FNFE_PROXYPORTA write FNFE_PROXYPORTA;
    const NFE_PROXYPORTA_Name = 'NFE_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYUSUARIO', ftString, 50)]
    [Dictionary('NFE_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROXYUSUARIO: String read FNFE_PROXYUSUARIO write FNFE_PROXYUSUARIO;
    const NFE_PROXYUSUARIO_Name = 'NFE_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PROXYSENHA', ftString, 25)]
    [Dictionary('NFE_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROXYSENHA: String read FNFE_PROXYSENHA write FNFE_PROXYSENHA;
    const NFE_PROXYSENHA_Name = 'NFE_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('NFE_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHLOGOMARCA: String read FNFE_PATHLOGOMARCA write FNFE_PATHLOGOMARCA;
    const NFE_PATHLOGOMARCA_Name = 'NFE_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHSCHEMA', ftString, 255)]
    [Dictionary('NFE_PATHSCHEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHSCHEMA: String read FNFE_PATHSCHEMA write FNFE_PATHSCHEMA;
    const NFE_PATHSCHEMA_Name = 'NFE_PATHSCHEMA';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('NFE_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHREPOSITORIO: String read FNFE_PATHREPOSITORIO write FNFE_PATHREPOSITORIO;
    const NFE_PATHREPOSITORIO_Name = 'NFE_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('NFE_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('NFE_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PATHARQENVIORESPOSTA: String read FNFE_PATHARQENVIORESPOSTA write FNFE_PATHARQENVIORESPOSTA;
    const NFE_PATHARQENVIORESPOSTA_Name = 'NFE_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('NFE_ATUALIZARNOTASINICIAR', ftString, 1)]
    [Dictionary('NFE_ATUALIZARNOTASINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ATUALIZARNOTASINICIAR: String read FNFE_ATUALIZARNOTASINICIAR write FNFE_ATUALIZARNOTASINICIAR;
    const NFE_ATUALIZARNOTASINICIAR_Name = 'NFE_ATUALIZARNOTASINICIAR';

    [Restrictions([NoValidate])]
    [Column('NFE_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('NFE_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ENVIAREMAILAPOSAUTORIZACAO: String read FNFE_ENVIAREMAILAPOSAUTORIZACAO write FNFE_ENVIAREMAILAPOSAUTORIZACAO;
    const NFE_ENVIAREMAILAPOSAUTORIZACAO_Name = 'NFE_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_TIPODESCRICAOPRODUTO', ftString, 1)]
    [Dictionary('NFE_TIPODESCRICAOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPODESCRICAOPRODUTO: String read FNFE_TIPODESCRICAOPRODUTO write FNFE_TIPODESCRICAOPRODUTO;
    const NFE_TIPODESCRICAOPRODUTO_Name = 'NFE_TIPODESCRICAOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('NFE_MENSAGEMRODAPENOTASAIDA', ftString, 5000)]
    [Dictionary('NFE_MENSAGEMRODAPENOTASAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MENSAGEMRODAPENOTASAIDA: String read FNFE_MENSAGEMRODAPENOTASAIDA write FNFE_MENSAGEMRODAPENOTASAIDA;
    const NFE_MENSAGEMRODAPENOTASAIDA_Name = 'NFE_MENSAGEMRODAPENOTASAIDA';

    [Restrictions([NoValidate])]
    [Column('NFE_MENSAGEMRODAPENOTAENTRADA', ftString, 5000)]
    [Dictionary('NFE_MENSAGEMRODAPENOTAENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MENSAGEMRODAPENOTAENTRADA: String read FNFE_MENSAGEMRODAPENOTAENTRADA write FNFE_MENSAGEMRODAPENOTAENTRADA;
    const NFE_MENSAGEMRODAPENOTAENTRADA_Name = 'NFE_MENSAGEMRODAPENOTAENTRADA';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('NFE_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILSERVIDORENVIO: String read FNFE_EMAILSERVIDORENVIO write FNFE_EMAILSERVIDORENVIO;
    const NFE_EMAILSERVIDORENVIO_Name = 'NFE_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILENVIO', ftString, 100)]
    [Dictionary('NFE_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILENVIO: String read FNFE_EMAILENVIO write FNFE_EMAILENVIO;
    const NFE_EMAILENVIO_Name = 'NFE_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('NFE_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILUSUARIOENVIO: String read FNFE_EMAILUSUARIOENVIO write FNFE_EMAILUSUARIOENVIO;
    const NFE_EMAILUSUARIOENVIO_Name = 'NFE_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('NFE_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILSENHAENVIO: String read FNFE_EMAILSENHAENVIO write FNFE_EMAILSENHAENVIO;
    const NFE_EMAILSENHAENVIO_Name = 'NFE_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('NFE_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_EMAILPORTAENVIO: Integer read FNFE_EMAILPORTAENVIO write FNFE_EMAILPORTAENVIO;
    const NFE_EMAILPORTAENVIO_Name = 'NFE_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILSSL', ftString, 1)]
    [Dictionary('NFE_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILSSL: String read FNFE_EMAILSSL write FNFE_EMAILSSL;
    const NFE_EMAILSSL_Name = 'NFE_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('NFE_ORDEMIMPRESSAOITENS', ftString, 1)]
    [Dictionary('NFE_ORDEMIMPRESSAOITENS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_ORDEMIMPRESSAOITENS: String read FNFE_ORDEMIMPRESSAOITENS write FNFE_ORDEMIMPRESSAOITENS;
    const NFE_ORDEMIMPRESSAOITENS_Name = 'NFE_ORDEMIMPRESSAOITENS';

    [Restrictions([NoValidate])]
    [Column('NFE_SSLLIB', ftString, 1)]
    [Dictionary('NFE_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SSLLIB: String read FNFE_SSLLIB write FNFE_SSLLIB;
    const NFE_SSLLIB_Name = 'NFE_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAONFC', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAONFC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAONFC: String read FMNF_CODIGOPADRAONFC write FMNF_CODIGOPADRAONFC;
    const MNF_CODIGOPADRAONFC_Name = 'MNF_CODIGOPADRAONFC';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIENFC', ftString, 3)]
    [Dictionary('NFE_SERIENFC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIENFC: String read FNFE_SERIENFC write FNFE_SERIENFC;
    const NFE_SERIENFC_Name = 'NFE_SERIENFC';

    [Restrictions([NoValidate])]
    [Column('NFE_CODIGOCSC', ftString, 50)]
    [Dictionary('NFE_CODIGOCSC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CODIGOCSC: String read FNFE_CODIGOCSC write FNFE_CODIGOCSC;
    const NFE_CODIGOCSC_Name = 'NFE_CODIGOCSC';

    [Restrictions([NoValidate])]
    [Column('NFE_MOTIVOCONTIGENCIA', ftString, 5000)]
    [Dictionary('NFE_MOTIVOCONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_MOTIVOCONTIGENCIA: String read FNFE_MOTIVOCONTIGENCIA write FNFE_MOTIVOCONTIGENCIA;
    const NFE_MOTIVOCONTIGENCIA_Name = 'NFE_MOTIVOCONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('NFE_CODIGOIDCSC', ftInteger)]
    [Dictionary('NFE_CODIGOIDCSC', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_CODIGOIDCSC: Integer read FNFE_CODIGOIDCSC write FNFE_CODIGOIDCSC;
    const NFE_CODIGOIDCSC_Name = 'NFE_CODIGOIDCSC';

    [Restrictions([NoValidate])]
    [Column('NFE_IMPRIMENOTAPROMISSORIANFCE', ftString, 1)]
    [Dictionary('NFE_IMPRIMENOTAPROMISSORIANFCE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_IMPRIMENOTAPROMISSORIANFCE: String read FNFE_IMPRIMENOTAPROMISSORIANFCE write FNFE_IMPRIMENOTAPROMISSORIANFCE;
    const NFE_IMPRIMENOTAPROMISSORIANFCE_Name = 'NFE_IMPRIMENOTAPROMISSORIANFCE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOPADRAOSERVICO', ftString, 2)]
    [Dictionary('MNF_CODIGOPADRAOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOPADRAOSERVICO: String read FMNF_CODIGOPADRAOSERVICO write FMNF_CODIGOPADRAOSERVICO;
    const MNF_CODIGOPADRAOSERVICO_Name = 'MNF_CODIGOPADRAOSERVICO';

    [Restrictions([NoValidate])]
    [Column('NFSE_SERIESERVICO', ftString, 3)]
    [Dictionary('NFSE_SERIESERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_SERIESERVICO: String read FNFSE_SERIESERVICO write FNFSE_SERIESERVICO;
    const NFSE_SERIESERVICO_Name = 'NFSE_SERIESERVICO';

    [Restrictions([NoValidate])]
    [Column('NFSE_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('NFSE_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_AMBIENTEENVIO: String read FNFSE_AMBIENTEENVIO write FNFSE_AMBIENTEENVIO;
    const NFSE_AMBIENTEENVIO_Name = 'NFSE_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('NFSE_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_CERTIFICADONUMEROSERIE: String read FNFSE_CERTIFICADONUMEROSERIE write FNFSE_CERTIFICADONUMEROSERIE;
    const NFSE_CERTIFICADONUMEROSERIE_Name = 'NFSE_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('NFSE_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('NFSE_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_CERTIFICADOSENHA: String read FNFSE_CERTIFICADOSENHA write FNFSE_CERTIFICADOSENHA;
    const NFSE_CERTIFICADOSENHA_Name = 'NFSE_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('NFSE_SSLLIB', ftString, 1)]
    [Dictionary('NFSE_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_SSLLIB: String read FNFSE_SSLLIB write FNFSE_SSLLIB;
    const NFSE_SSLLIB_Name = 'NFSE_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('NFSE_IBGECIDADE', ftString, 7)]
    [Dictionary('NFSE_IBGECIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_IBGECIDADE: String read FNFSE_IBGECIDADE write FNFSE_IBGECIDADE;
    const NFSE_IBGECIDADE_Name = 'NFSE_IBGECIDADE';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYHOST', ftString, 50)]
    [Dictionary('NFSE_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PROXYHOST: String read FNFSE_PROXYHOST write FNFSE_PROXYHOST;
    const NFSE_PROXYHOST_Name = 'NFSE_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYPORTA', ftInteger)]
    [Dictionary('NFSE_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFSE_PROXYPORTA: Integer read FNFSE_PROXYPORTA write FNFSE_PROXYPORTA;
    const NFSE_PROXYPORTA_Name = 'NFSE_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYUSUARIO', ftString, 50)]
    [Dictionary('NFSE_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PROXYUSUARIO: String read FNFSE_PROXYUSUARIO write FNFSE_PROXYUSUARIO;
    const NFSE_PROXYUSUARIO_Name = 'NFSE_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_PROXYSENHA', ftString, 25)]
    [Dictionary('NFSE_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PROXYSENHA: String read FNFSE_PROXYSENHA write FNFSE_PROXYSENHA;
    const NFSE_PROXYSENHA_Name = 'NFSE_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('NFSE_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHLOGOMARCA: String read FNFSE_PATHLOGOMARCA write FNFSE_PATHLOGOMARCA;
    const NFSE_PATHLOGOMARCA_Name = 'NFSE_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHLOGOMARCAPREFEITURA', ftString, 255)]
    [Dictionary('NFSE_PATHLOGOMARCAPREFEITURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHLOGOMARCAPREFEITURA: String read FNFSE_PATHLOGOMARCAPREFEITURA write FNFSE_PATHLOGOMARCAPREFEITURA;
    const NFSE_PATHLOGOMARCAPREFEITURA_Name = 'NFSE_PATHLOGOMARCAPREFEITURA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHSCHEMAPROVEDOR', ftString, 255)]
    [Dictionary('NFSE_PATHSCHEMAPROVEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHSCHEMAPROVEDOR: String read FNFSE_PATHSCHEMAPROVEDOR write FNFSE_PATHSCHEMAPROVEDOR;
    const NFSE_PATHSCHEMAPROVEDOR_Name = 'NFSE_PATHSCHEMAPROVEDOR';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('NFSE_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHREPOSITORIO: String read FNFSE_PATHREPOSITORIO write FNFSE_PATHREPOSITORIO;
    const NFSE_PATHREPOSITORIO_Name = 'NFSE_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('NFSE_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHARQENVIORESPOSTA: String read FNFSE_PATHARQENVIORESPOSTA write FNFSE_PATHARQENVIORESPOSTA;
    const NFSE_PATHARQENVIORESPOSTA_Name = 'NFSE_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('NFSE_PATHARQUIVOINI', ftString, 255)]
    [Dictionary('NFSE_PATHARQUIVOINI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_PATHARQUIVOINI: String read FNFSE_PATHARQUIVOINI write FNFSE_PATHARQUIVOINI;
    const NFSE_PATHARQUIVOINI_Name = 'NFSE_PATHARQUIVOINI';

    [Restrictions([NoValidate])]
    [Column('NFSE_ATUALIZARNOTASINICIAR', ftString, 1)]
    [Dictionary('NFSE_ATUALIZARNOTASINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_ATUALIZARNOTASINICIAR: String read FNFSE_ATUALIZARNOTASINICIAR write FNFSE_ATUALIZARNOTASINICIAR;
    const NFSE_ATUALIZARNOTASINICIAR_Name = 'NFSE_ATUALIZARNOTASINICIAR';

    [Restrictions([NoValidate])]
    [Column('NFSE_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('NFSE_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_ENVIAREMAILAPOSAUTORIZACAO: String read FNFSE_ENVIAREMAILAPOSAUTORIZACAO write FNFSE_ENVIAREMAILAPOSAUTORIZACAO;
    const NFSE_ENVIAREMAILAPOSAUTORIZACAO_Name = 'NFSE_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('NFSE_WEBUSUARIO', ftString, 50)]
    [Dictionary('NFSE_WEBUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_WEBUSUARIO: String read FNFSE_WEBUSUARIO write FNFSE_WEBUSUARIO;
    const NFSE_WEBUSUARIO_Name = 'NFSE_WEBUSUARIO';

    [Restrictions([NoValidate])]
    [Column('NFSE_WEBSENHA', ftString, 25)]
    [Dictionary('NFSE_WEBSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_WEBSENHA: String read FNFSE_WEBSENHA write FNFSE_WEBSENHA;
    const NFSE_WEBSENHA_Name = 'NFSE_WEBSENHA';

    [Restrictions([NoValidate])]
    [Column('NFSE_WEBFRASESECRETA', ftString, 50)]
    [Dictionary('NFSE_WEBFRASESECRETA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_WEBFRASESECRETA: String read FNFSE_WEBFRASESECRETA write FNFSE_WEBFRASESECRETA;
    const NFSE_WEBFRASESECRETA_Name = 'NFSE_WEBFRASESECRETA';

    [Restrictions([NoValidate])]
    [Column('NFSE_REGIMETRIBUTACAO', ftInteger)]
    [Dictionary('NFSE_REGIMETRIBUTACAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFSE_REGIMETRIBUTACAO: Integer read FNFSE_REGIMETRIBUTACAO write FNFSE_REGIMETRIBUTACAO;
    const NFSE_REGIMETRIBUTACAO_Name = 'NFSE_REGIMETRIBUTACAO';

    [Restrictions([NoValidate])]
    [Column('NFSE_INCENTIVADORCULTURAL', ftString, 1)]
    [Dictionary('NFSE_INCENTIVADORCULTURAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_INCENTIVADORCULTURAL: String read FNFSE_INCENTIVADORCULTURAL write FNFSE_INCENTIVADORCULTURAL;
    const NFSE_INCENTIVADORCULTURAL_Name = 'NFSE_INCENTIVADORCULTURAL';

    [Restrictions([NoValidate])]
    [Column('NFSE_CIDADE', ftString, 100)]
    [Dictionary('NFSE_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFSE_CIDADE: String read FNFSE_CIDADE write FNFSE_CIDADE;
    const NFSE_CIDADE_Name = 'NFSE_CIDADE';

    [Restrictions([NoValidate])]
    [Column('NFE_ULTIMONSUMANIFESTACAO', ftInteger)]
    [Dictionary('NFE_ULTIMONSUMANIFESTACAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ULTIMONSUMANIFESTACAO: Integer read FNFE_ULTIMONSUMANIFESTACAO write FNFE_ULTIMONSUMANIFESTACAO;
    const NFE_ULTIMONSUMANIFESTACAO_Name = 'NFE_ULTIMONSUMANIFESTACAO';

    [Restrictions([NoValidate])]
    [Column('NFSE_VALORMINRETENCAOFEDERAL', ftBCD)]
    [Dictionary('NFSE_VALORMINRETENCAOFEDERAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFSE_VALORMINRETENCAOFEDERAL: Double read FNFSE_VALORMINRETENCAOFEDERAL write FNFSE_VALORMINRETENCAOFEDERAL;
    const NFSE_VALORMINRETENCAOFEDERAL_Name = 'NFSE_VALORMINRETENCAOFEDERAL';

    [Restrictions([NoValidate])]
    [Column('NFSE_VALORMINRETENCAOIR', ftBCD)]
    [Dictionary('NFSE_VALORMINRETENCAOIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFSE_VALORMINRETENCAOIR: Double read FNFSE_VALORMINRETENCAOIR write FNFSE_VALORMINRETENCAOIR;
    const NFSE_VALORMINRETENCAOIR_Name = 'NFSE_VALORMINRETENCAOIR';

    [Restrictions([NoValidate])]
    [Column('NFE_CNPJSEFAZUFEMITENTE', ftString, 14)]
    [Dictionary('NFE_CNPJSEFAZUFEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CNPJSEFAZUFEMITENTE: String read FNFE_CNPJSEFAZUFEMITENTE write FNFE_CNPJSEFAZUFEMITENTE;
    const NFE_CNPJSEFAZUFEMITENTE_Name = 'NFE_CNPJSEFAZUFEMITENTE';

    [Restrictions([NoValidate])]
    [Column('NFE_EMAILTLS', ftString, 1)]
    [Dictionary('NFE_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_EMAILTLS: String read FNFE_EMAILTLS write FNFE_EMAILTLS;
    const NFE_EMAILTLS_Name = 'NFE_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('NFE_DADOSCERTIFICADO_A1PFX', ftBlob)]
    [Dictionary('NFE_DADOSCERTIFICADO_A1PFX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_DADOSCERTIFICADO_A1PFX: TBlob read FNFE_DADOSCERTIFICADO_A1PFX write FNFE_DADOSCERTIFICADO_A1PFX;
    const NFE_DADOSCERTIFICADO_A1PFX_Name = 'NFE_DADOSCERTIFICADO_A1PFX';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONFIG_00_03)

end.
