unit express.dbo.CONFIG_00_02;

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
  [Table('CONFIG_00_02', '')]
  [PrimaryKey('CFG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFG_CODIGO')]
  TDtoCONFIG_00_02 = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FMNF_CODIGO: String;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FTDC_CODIGO: String;
    FPRO_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FCTR_ESPECIE: String;
    FCTR_APOLICE: String;
    FCTR_NATUREZA: String;
    FCTR_COBRADORA: String;
    FCTR_NATUREZACARGA: String;
    FCTR_CONFIGURACOES: String;
    FCTR_PERCENTUALICMS: Double;
    FCTR_SERIECONTIGENCIA: String;
    FCTR_MANIFESTOCARGACPA: String;
    FCTR_TIPOMEIOTRANSPORTE: String;
    FCTR_CONTRATORODOVIARIOCPA: String;
    FCTR_OBSERVACAO: String;
    FCTR_AMBIENTEENVIO: String;
    FCTR_TIPOEMISSAO: String;
    FCTR_FINALIDADE: String;
    FCTR_TIPODACTE: String;
    FCTR_CERTIFICADONUMEROSERIE: String;
    FCTR_CERTIFICADOSENHA: String;
    FCTR_UFDESTINO: String;
    FCTR_PROXYHOST: String;
    FCTR_PROXYPORTA: Integer;
    FCTR_PROXYUSUARIO: String;
    FCTR_PROXYSENHA: String;
    FCTR_PATHLOGOMARCA: String;
    FCTR_PATHSCHEMA: String;
    FCTR_PATHREPOSITORIO: String;
    FCTR_PATHARQENVIORESPOSTA: String;
    FCTR_ATUALIZARCTEINICIAR: String;
    FCTR_ENVIAREMAILAPOSAUTORIZACAO: String;
    FCFG_DATAALTERACAO: TDateTime;
    FCTR_RNTRC: String;
    FFPG_CODIGO: Integer;
    FNTO_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FCTR_EMAILSERVIDORENVIO: String;
    FCTR_EMAILENVIO: String;
    FCTR_EMAILUSUARIOENVIO: String;
    FCTR_EMAILSENHAENVIO: String;
    FCTR_EMAILPORTAENVIO: Integer;
    FCTR_EMAILSSL: String;
    FMFC_TIPOEMISSAO: String;
    FMFC_AMBIENTEENVIO: String;
    FMFC_TIPODACTE: String;
    FMFC_CERTIFICADONUMEROSERIE: String;
    FMFC_CERTIFICADOSENHA: String;
    FMFC_UFDESTINO: String;
    FMFC_PROXYHOST: String;
    FMFC_PROXYPORTA: Integer;
    FMFC_PROXYUSUARIO: String;
    FMFC_PROXYSENHA: String;
    FMFC_PATHLOGOMARCA: String;
    FMFC_PATHSCHEMA: String;
    FMFC_PATHREPOSITORIO: String;
    FMFC_PATHARQENVIORESPOSTA: String;
    FMFC_ATUALIZARCTEINICIAR: String;
    FMFC_ENVIAREMAILAPOSAUTORIZACAO: String;
    FMFC_EMAILSERVIDORENVIO: String;
    FMFC_EMAILENVIO: String;
    FMFC_EMAILUSUARIOENVIO: String;
    FMFC_EMAILSENHAENVIO: String;
    FMFC_EMAILPORTAENVIO: Integer;
    FMFC_EMAILSSL: String;
    FMNF_CODIGO_MFC: String;
    FMFC_SERIE: String;
    FMFC_SUBSERIE: String;
    FMFC_SERIECONTIGENCIA: String;
    FMFC_TIPOEMITENTE: String;
    FCTR_PERCENTUALIBPT: Double;
    FCTR_TIPOFRETE: String;
    FCTR_PERCENTUALIBPTESTADUAL: Double;
    FCTR_PERCENTUALIBPTNACIONAL: Double;
    FCTR_SSLLIB: String;
    FMFC_SSLLIB: String;
    FCTR_GLOBALIZADO: String;
    FCTR_PERCENTUALCDICMSSIMPLES: Double;
    FCTR_USUARIOAPISEGURADORA: String;
    FCTR_SENHAAPISEGURADORA: String;
    FCTR_CODIGOAPISEGURADORA: String;
    FCTR_AVERBARAUTOMATICAMENTE: String;
    FMFC_DECLARARAUTOMATICAMENTE: String;
    FMFC_INTEGRADORACIOT: String;
    FMFC_USUARIOINTEGRADORACIOT: String;
    FMFC_SENHAINTEGRADORACIOT: String;
    FMFC_HASHINTEGRADORACIOT: String;
    FMFC_PATHSCHEMACIOT: String;
    FMFC_PATHREPOSITORIOCIOT: String;
    FCTR_SERIEINTERESTADUAL: String;
    FCTR_EMAILTLS: String;
    FMFC_EMAILTLS: String;
  public 
    { Public declarations } 
     const Table      = 'CONFIG_00_02';
     const PrimaryKey = 'CFG_CODIGO';
     const Sequence   = 'SEQ_CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

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

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 3)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

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
    [Column('CTR_ESPECIE', ftString, 15)]
    [Dictionary('CTR_ESPECIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ESPECIE: String read FCTR_ESPECIE write FCTR_ESPECIE;
    const CTR_ESPECIE_Name = 'CTR_ESPECIE';

    [Restrictions([NoValidate])]
    [Column('CTR_APOLICE', ftString, 15)]
    [Dictionary('CTR_APOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_APOLICE: String read FCTR_APOLICE write FCTR_APOLICE;
    const CTR_APOLICE_Name = 'CTR_APOLICE';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZA', ftString, 20)]
    [Dictionary('CTR_NATUREZA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZA: String read FCTR_NATUREZA write FCTR_NATUREZA;
    const CTR_NATUREZA_Name = 'CTR_NATUREZA';

    [Restrictions([NoValidate])]
    [Column('CTR_COBRADORA', ftString, 15)]
    [Dictionary('CTR_COBRADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_COBRADORA: String read FCTR_COBRADORA write FCTR_COBRADORA;
    const CTR_COBRADORA_Name = 'CTR_COBRADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZACARGA', ftString, 15)]
    [Dictionary('CTR_NATUREZACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZACARGA: String read FCTR_NATUREZACARGA write FCTR_NATUREZACARGA;
    const CTR_NATUREZACARGA_Name = 'CTR_NATUREZACARGA';

    [Restrictions([NoValidate])]
    [Column('CTR_CONFIGURACOES', ftString, 100)]
    [Dictionary('CTR_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CONFIGURACOES: String read FCTR_CONFIGURACOES write FCTR_CONFIGURACOES;
    const CTR_CONFIGURACOES_Name = 'CTR_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALICMS', ftBCD)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIECONTIGENCIA', ftString, 3)]
    [Dictionary('CTR_SERIECONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIECONTIGENCIA: String read FCTR_SERIECONTIGENCIA write FCTR_SERIECONTIGENCIA;
    const CTR_SERIECONTIGENCIA_Name = 'CTR_SERIECONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTR_MANIFESTOCARGACPA', ftString, 1)]
    [Dictionary('CTR_MANIFESTOCARGACPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_MANIFESTOCARGACPA: String read FCTR_MANIFESTOCARGACPA write FCTR_MANIFESTOCARGACPA;
    const CTR_MANIFESTOCARGACPA_Name = 'CTR_MANIFESTOCARGACPA';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOMEIOTRANSPORTE', ftString, 4)]
    [Dictionary('CTR_TIPOMEIOTRANSPORTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOMEIOTRANSPORTE: String read FCTR_TIPOMEIOTRANSPORTE write FCTR_TIPOMEIOTRANSPORTE;
    const CTR_TIPOMEIOTRANSPORTE_Name = 'CTR_TIPOMEIOTRANSPORTE';

    [Restrictions([NoValidate])]
    [Column('CTR_CONTRATORODOVIARIOCPA', ftString, 1)]
    [Dictionary('CTR_CONTRATORODOVIARIOCPA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CONTRATORODOVIARIOCPA: String read FCTR_CONTRATORODOVIARIOCPA write FCTR_CONTRATORODOVIARIOCPA;
    const CTR_CONTRATORODOVIARIOCPA_Name = 'CTR_CONTRATORODOVIARIOCPA';

    [Restrictions([NoValidate])]
    [Column('CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO: String read FCTR_OBSERVACAO write FCTR_OBSERVACAO;
    const CTR_OBSERVACAO_Name = 'CTR_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('CTR_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AMBIENTEENVIO: String read FCTR_AMBIENTEENVIO write FCTR_AMBIENTEENVIO;
    const CTR_AMBIENTEENVIO_Name = 'CTR_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOEMISSAO', ftString, 1)]
    [Dictionary('CTR_TIPOEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOEMISSAO: String read FCTR_TIPOEMISSAO write FCTR_TIPOEMISSAO;
    const CTR_TIPOEMISSAO_Name = 'CTR_TIPOEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTR_FINALIDADE', ftString, 1)]
    [Dictionary('CTR_FINALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_FINALIDADE: String read FCTR_FINALIDADE write FCTR_FINALIDADE;
    const CTR_FINALIDADE_Name = 'CTR_FINALIDADE';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPODACTE', ftString, 1)]
    [Dictionary('CTR_TIPODACTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPODACTE: String read FCTR_TIPODACTE write FCTR_TIPODACTE;
    const CTR_TIPODACTE_Name = 'CTR_TIPODACTE';

    [Restrictions([NoValidate])]
    [Column('CTR_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('CTR_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CERTIFICADONUMEROSERIE: String read FCTR_CERTIFICADONUMEROSERIE write FCTR_CERTIFICADONUMEROSERIE;
    const CTR_CERTIFICADONUMEROSERIE_Name = 'CTR_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('CTR_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CERTIFICADOSENHA: String read FCTR_CERTIFICADOSENHA write FCTR_CERTIFICADOSENHA;
    const CTR_CERTIFICADOSENHA_Name = 'CTR_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('CTR_UFDESTINO', ftString, 2)]
    [Dictionary('CTR_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UFDESTINO: String read FCTR_UFDESTINO write FCTR_UFDESTINO;
    const CTR_UFDESTINO_Name = 'CTR_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYHOST', ftString, 50)]
    [Dictionary('CTR_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROXYHOST: String read FCTR_PROXYHOST write FCTR_PROXYHOST;
    const CTR_PROXYHOST_Name = 'CTR_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYPORTA', ftInteger)]
    [Dictionary('CTR_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_PROXYPORTA: Integer read FCTR_PROXYPORTA write FCTR_PROXYPORTA;
    const CTR_PROXYPORTA_Name = 'CTR_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYUSUARIO', ftString, 50)]
    [Dictionary('CTR_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROXYUSUARIO: String read FCTR_PROXYUSUARIO write FCTR_PROXYUSUARIO;
    const CTR_PROXYUSUARIO_Name = 'CTR_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('CTR_PROXYSENHA', ftString, 25)]
    [Dictionary('CTR_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROXYSENHA: String read FCTR_PROXYSENHA write FCTR_PROXYSENHA;
    const CTR_PROXYSENHA_Name = 'CTR_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('CTR_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHLOGOMARCA: String read FCTR_PATHLOGOMARCA write FCTR_PATHLOGOMARCA;
    const CTR_PATHLOGOMARCA_Name = 'CTR_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHSCHEMA', ftString, 255)]
    [Dictionary('CTR_PATHSCHEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHSCHEMA: String read FCTR_PATHSCHEMA write FCTR_PATHSCHEMA;
    const CTR_PATHSCHEMA_Name = 'CTR_PATHSCHEMA';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('CTR_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHREPOSITORIO: String read FCTR_PATHREPOSITORIO write FCTR_PATHREPOSITORIO;
    const CTR_PATHREPOSITORIO_Name = 'CTR_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('CTR_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('CTR_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PATHARQENVIORESPOSTA: String read FCTR_PATHARQENVIORESPOSTA write FCTR_PATHARQENVIORESPOSTA;
    const CTR_PATHARQENVIORESPOSTA_Name = 'CTR_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('CTR_ATUALIZARCTEINICIAR', ftString, 1)]
    [Dictionary('CTR_ATUALIZARCTEINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ATUALIZARCTEINICIAR: String read FCTR_ATUALIZARCTEINICIAR write FCTR_ATUALIZARCTEINICIAR;
    const CTR_ATUALIZARCTEINICIAR_Name = 'CTR_ATUALIZARCTEINICIAR';

    [Restrictions([NoValidate])]
    [Column('CTR_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('CTR_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ENVIAREMAILAPOSAUTORIZACAO: String read FCTR_ENVIAREMAILAPOSAUTORIZACAO write FCTR_ENVIAREMAILAPOSAUTORIZACAO;
    const CTR_ENVIAREMAILAPOSAUTORIZACAO_Name = 'CTR_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_RNTRC', ftString, 14)]
    [Dictionary('CTR_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_RNTRC: String read FCTR_RNTRC write FCTR_RNTRC;
    const CTR_RNTRC_Name = 'CTR_RNTRC';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('CTR_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILSERVIDORENVIO: String read FCTR_EMAILSERVIDORENVIO write FCTR_EMAILSERVIDORENVIO;
    const CTR_EMAILSERVIDORENVIO_Name = 'CTR_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILENVIO', ftString, 100)]
    [Dictionary('CTR_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILENVIO: String read FCTR_EMAILENVIO write FCTR_EMAILENVIO;
    const CTR_EMAILENVIO_Name = 'CTR_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('CTR_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILUSUARIOENVIO: String read FCTR_EMAILUSUARIOENVIO write FCTR_EMAILUSUARIOENVIO;
    const CTR_EMAILUSUARIOENVIO_Name = 'CTR_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('CTR_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILSENHAENVIO: String read FCTR_EMAILSENHAENVIO write FCTR_EMAILSENHAENVIO;
    const CTR_EMAILSENHAENVIO_Name = 'CTR_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('CTR_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_EMAILPORTAENVIO: Integer read FCTR_EMAILPORTAENVIO write FCTR_EMAILPORTAENVIO;
    const CTR_EMAILPORTAENVIO_Name = 'CTR_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILSSL', ftString, 1)]
    [Dictionary('CTR_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILSSL: String read FCTR_EMAILSSL write FCTR_EMAILSSL;
    const CTR_EMAILSSL_Name = 'CTR_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMISSAO', ftString, 1)]
    [Dictionary('MFC_TIPOEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMISSAO: String read FMFC_TIPOEMISSAO write FMFC_TIPOEMISSAO;
    const MFC_TIPOEMISSAO_Name = 'MFC_TIPOEMISSAO';

    [Restrictions([NoValidate])]
    [Column('MFC_AMBIENTEENVIO', ftString, 1)]
    [Dictionary('MFC_AMBIENTEENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_AMBIENTEENVIO: String read FMFC_AMBIENTEENVIO write FMFC_AMBIENTEENVIO;
    const MFC_AMBIENTEENVIO_Name = 'MFC_AMBIENTEENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPODACTE', ftString, 1)]
    [Dictionary('MFC_TIPODACTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPODACTE: String read FMFC_TIPODACTE write FMFC_TIPODACTE;
    const MFC_TIPODACTE_Name = 'MFC_TIPODACTE';

    [Restrictions([NoValidate])]
    [Column('MFC_CERTIFICADONUMEROSERIE', ftString, 50)]
    [Dictionary('MFC_CERTIFICADONUMEROSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CERTIFICADONUMEROSERIE: String read FMFC_CERTIFICADONUMEROSERIE write FMFC_CERTIFICADONUMEROSERIE;
    const MFC_CERTIFICADONUMEROSERIE_Name = 'MFC_CERTIFICADONUMEROSERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_CERTIFICADOSENHA', ftString, 25)]
    [Dictionary('MFC_CERTIFICADOSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CERTIFICADOSENHA: String read FMFC_CERTIFICADOSENHA write FMFC_CERTIFICADOSENHA;
    const MFC_CERTIFICADOSENHA_Name = 'MFC_CERTIFICADOSENHA';

    [Restrictions([NoValidate])]
    [Column('MFC_UFDESTINO', ftString, 2)]
    [Dictionary('MFC_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UFDESTINO: String read FMFC_UFDESTINO write FMFC_UFDESTINO;
    const MFC_UFDESTINO_Name = 'MFC_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYHOST', ftString, 50)]
    [Dictionary('MFC_PROXYHOST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROXYHOST: String read FMFC_PROXYHOST write FMFC_PROXYHOST;
    const MFC_PROXYHOST_Name = 'MFC_PROXYHOST';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYPORTA', ftInteger)]
    [Dictionary('MFC_PROXYPORTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_PROXYPORTA: Integer read FMFC_PROXYPORTA write FMFC_PROXYPORTA;
    const MFC_PROXYPORTA_Name = 'MFC_PROXYPORTA';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYUSUARIO', ftString, 50)]
    [Dictionary('MFC_PROXYUSUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROXYUSUARIO: String read FMFC_PROXYUSUARIO write FMFC_PROXYUSUARIO;
    const MFC_PROXYUSUARIO_Name = 'MFC_PROXYUSUARIO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROXYSENHA', ftString, 25)]
    [Dictionary('MFC_PROXYSENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROXYSENHA: String read FMFC_PROXYSENHA write FMFC_PROXYSENHA;
    const MFC_PROXYSENHA_Name = 'MFC_PROXYSENHA';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHLOGOMARCA', ftString, 255)]
    [Dictionary('MFC_PATHLOGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHLOGOMARCA: String read FMFC_PATHLOGOMARCA write FMFC_PATHLOGOMARCA;
    const MFC_PATHLOGOMARCA_Name = 'MFC_PATHLOGOMARCA';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHSCHEMA', ftString, 255)]
    [Dictionary('MFC_PATHSCHEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHSCHEMA: String read FMFC_PATHSCHEMA write FMFC_PATHSCHEMA;
    const MFC_PATHSCHEMA_Name = 'MFC_PATHSCHEMA';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHREPOSITORIO', ftString, 255)]
    [Dictionary('MFC_PATHREPOSITORIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHREPOSITORIO: String read FMFC_PATHREPOSITORIO write FMFC_PATHREPOSITORIO;
    const MFC_PATHREPOSITORIO_Name = 'MFC_PATHREPOSITORIO';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHARQENVIORESPOSTA', ftString, 255)]
    [Dictionary('MFC_PATHARQENVIORESPOSTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHARQENVIORESPOSTA: String read FMFC_PATHARQENVIORESPOSTA write FMFC_PATHARQENVIORESPOSTA;
    const MFC_PATHARQENVIORESPOSTA_Name = 'MFC_PATHARQENVIORESPOSTA';

    [Restrictions([NoValidate])]
    [Column('MFC_ATUALIZARCTEINICIAR', ftString, 1)]
    [Dictionary('MFC_ATUALIZARCTEINICIAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_ATUALIZARCTEINICIAR: String read FMFC_ATUALIZARCTEINICIAR write FMFC_ATUALIZARCTEINICIAR;
    const MFC_ATUALIZARCTEINICIAR_Name = 'MFC_ATUALIZARCTEINICIAR';

    [Restrictions([NoValidate])]
    [Column('MFC_ENVIAREMAILAPOSAUTORIZACAO', ftString, 1)]
    [Dictionary('MFC_ENVIAREMAILAPOSAUTORIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_ENVIAREMAILAPOSAUTORIZACAO: String read FMFC_ENVIAREMAILAPOSAUTORIZACAO write FMFC_ENVIAREMAILAPOSAUTORIZACAO;
    const MFC_ENVIAREMAILAPOSAUTORIZACAO_Name = 'MFC_ENVIAREMAILAPOSAUTORIZACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILSERVIDORENVIO', ftString, 100)]
    [Dictionary('MFC_EMAILSERVIDORENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILSERVIDORENVIO: String read FMFC_EMAILSERVIDORENVIO write FMFC_EMAILSERVIDORENVIO;
    const MFC_EMAILSERVIDORENVIO_Name = 'MFC_EMAILSERVIDORENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILENVIO', ftString, 100)]
    [Dictionary('MFC_EMAILENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILENVIO: String read FMFC_EMAILENVIO write FMFC_EMAILENVIO;
    const MFC_EMAILENVIO_Name = 'MFC_EMAILENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILUSUARIOENVIO', ftString, 100)]
    [Dictionary('MFC_EMAILUSUARIOENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILUSUARIOENVIO: String read FMFC_EMAILUSUARIOENVIO write FMFC_EMAILUSUARIOENVIO;
    const MFC_EMAILUSUARIOENVIO_Name = 'MFC_EMAILUSUARIOENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILSENHAENVIO', ftString, 30)]
    [Dictionary('MFC_EMAILSENHAENVIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILSENHAENVIO: String read FMFC_EMAILSENHAENVIO write FMFC_EMAILSENHAENVIO;
    const MFC_EMAILSENHAENVIO_Name = 'MFC_EMAILSENHAENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILPORTAENVIO', ftInteger)]
    [Dictionary('MFC_EMAILPORTAENVIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_EMAILPORTAENVIO: Integer read FMFC_EMAILPORTAENVIO write FMFC_EMAILPORTAENVIO;
    const MFC_EMAILPORTAENVIO_Name = 'MFC_EMAILPORTAENVIO';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILSSL', ftString, 1)]
    [Dictionary('MFC_EMAILSSL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILSSL: String read FMFC_EMAILSSL write FMFC_EMAILSSL;
    const MFC_EMAILSSL_Name = 'MFC_EMAILSSL';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO_MFC', ftString, 2)]
    [Dictionary('MNF_CODIGO_MFC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO_MFC: String read FMNF_CODIGO_MFC write FMNF_CODIGO_MFC;
    const MNF_CODIGO_MFC_Name = 'MNF_CODIGO_MFC';

    [Restrictions([NoValidate])]
    [Column('MFC_SERIE', ftString, 3)]
    [Dictionary('MFC_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SERIE: String read FMFC_SERIE write FMFC_SERIE;
    const MFC_SERIE_Name = 'MFC_SERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_SUBSERIE', ftString, 2)]
    [Dictionary('MFC_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SUBSERIE: String read FMFC_SUBSERIE write FMFC_SUBSERIE;
    const MFC_SUBSERIE_Name = 'MFC_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_SERIECONTIGENCIA', ftString, 3)]
    [Dictionary('MFC_SERIECONTIGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SERIECONTIGENCIA: String read FMFC_SERIECONTIGENCIA write FMFC_SERIECONTIGENCIA;
    const MFC_SERIECONTIGENCIA_Name = 'MFC_SERIECONTIGENCIA';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMITENTE', ftString, 1)]
    [Dictionary('MFC_TIPOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMITENTE: String read FMFC_TIPOEMITENTE write FMFC_TIPOEMITENTE;
    const MFC_TIPOEMITENTE_Name = 'MFC_TIPOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPT', ftBCD, 2097184, 2)]
    [Dictionary('CTR_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPT: Double read FCTR_PERCENTUALIBPT write FCTR_PERCENTUALIBPT;
    const CTR_PERCENTUALIBPT_Name = 'CTR_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPOFRETE', ftString, 1)]
    [Dictionary('CTR_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOFRETE: String read FCTR_TIPOFRETE write FCTR_TIPOFRETE;
    const CTR_TIPOFRETE_Name = 'CTR_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPTESTADUAL', ftBCD, 4456521, 2)]
    [Dictionary('CTR_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPTESTADUAL: Double read FCTR_PERCENTUALIBPTESTADUAL write FCTR_PERCENTUALIBPTESTADUAL;
    const CTR_PERCENTUALIBPTESTADUAL_Name = 'CTR_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALIBPTNACIONAL', ftBCD, 7798816, 2)]
    [Dictionary('CTR_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALIBPTNACIONAL: Double read FCTR_PERCENTUALIBPTNACIONAL write FCTR_PERCENTUALIBPTNACIONAL;
    const CTR_PERCENTUALIBPTNACIONAL_Name = 'CTR_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('CTR_SSLLIB', ftString, 1)]
    [Dictionary('CTR_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SSLLIB: String read FCTR_SSLLIB write FCTR_SSLLIB;
    const CTR_SSLLIB_Name = 'CTR_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('MFC_SSLLIB', ftString, 1)]
    [Dictionary('MFC_SSLLIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SSLLIB: String read FMFC_SSLLIB write FMFC_SSLLIB;
    const MFC_SSLLIB_Name = 'MFC_SSLLIB';

    [Restrictions([NoValidate])]
    [Column('CTR_GLOBALIZADO', ftString, 1)]
    [Dictionary('CTR_GLOBALIZADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_GLOBALIZADO: String read FCTR_GLOBALIZADO write FCTR_GLOBALIZADO;
    const CTR_GLOBALIZADO_Name = 'CTR_GLOBALIZADO';

    [Restrictions([NoValidate])]
    [Column('CTR_PERCENTUALCDICMSSIMPLES', ftBCD, 18, 4)]
    [Dictionary('CTR_PERCENTUALCDICMSSIMPLES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALCDICMSSIMPLES: Double read FCTR_PERCENTUALCDICMSSIMPLES write FCTR_PERCENTUALCDICMSSIMPLES;
    const CTR_PERCENTUALCDICMSSIMPLES_Name = 'CTR_PERCENTUALCDICMSSIMPLES';

    [Restrictions([NoValidate])]
    [Column('CTR_USUARIOAPISEGURADORA', ftString, 50)]
    [Dictionary('CTR_USUARIOAPISEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_USUARIOAPISEGURADORA: String read FCTR_USUARIOAPISEGURADORA write FCTR_USUARIOAPISEGURADORA;
    const CTR_USUARIOAPISEGURADORA_Name = 'CTR_USUARIOAPISEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_SENHAAPISEGURADORA', ftString, 25)]
    [Dictionary('CTR_SENHAAPISEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SENHAAPISEGURADORA: String read FCTR_SENHAAPISEGURADORA write FCTR_SENHAAPISEGURADORA;
    const CTR_SENHAAPISEGURADORA_Name = 'CTR_SENHAAPISEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_CODIGOAPISEGURADORA', ftString, 15)]
    [Dictionary('CTR_CODIGOAPISEGURADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CODIGOAPISEGURADORA: String read FCTR_CODIGOAPISEGURADORA write FCTR_CODIGOAPISEGURADORA;
    const CTR_CODIGOAPISEGURADORA_Name = 'CTR_CODIGOAPISEGURADORA';

    [Restrictions([NoValidate])]
    [Column('CTR_AVERBARAUTOMATICAMENTE', ftString, 1)]
    [Dictionary('CTR_AVERBARAUTOMATICAMENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_AVERBARAUTOMATICAMENTE: String read FCTR_AVERBARAUTOMATICAMENTE write FCTR_AVERBARAUTOMATICAMENTE;
    const CTR_AVERBARAUTOMATICAMENTE_Name = 'CTR_AVERBARAUTOMATICAMENTE';

    [Restrictions([NoValidate])]
    [Column('MFC_DECLARARAUTOMATICAMENTE', ftString, 1)]
    [Dictionary('MFC_DECLARARAUTOMATICAMENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_DECLARARAUTOMATICAMENTE: String read FMFC_DECLARARAUTOMATICAMENTE write FMFC_DECLARARAUTOMATICAMENTE;
    const MFC_DECLARARAUTOMATICAMENTE_Name = 'MFC_DECLARARAUTOMATICAMENTE';

    [Restrictions([NoValidate])]
    [Column('MFC_INTEGRADORACIOT', ftString, 1)]
    [Dictionary('MFC_INTEGRADORACIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_INTEGRADORACIOT: String read FMFC_INTEGRADORACIOT write FMFC_INTEGRADORACIOT;
    const MFC_INTEGRADORACIOT_Name = 'MFC_INTEGRADORACIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_USUARIOINTEGRADORACIOT', ftString, 50)]
    [Dictionary('MFC_USUARIOINTEGRADORACIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_USUARIOINTEGRADORACIOT: String read FMFC_USUARIOINTEGRADORACIOT write FMFC_USUARIOINTEGRADORACIOT;
    const MFC_USUARIOINTEGRADORACIOT_Name = 'MFC_USUARIOINTEGRADORACIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_SENHAINTEGRADORACIOT', ftString, 25)]
    [Dictionary('MFC_SENHAINTEGRADORACIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SENHAINTEGRADORACIOT: String read FMFC_SENHAINTEGRADORACIOT write FMFC_SENHAINTEGRADORACIOT;
    const MFC_SENHAINTEGRADORACIOT_Name = 'MFC_SENHAINTEGRADORACIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_HASHINTEGRADORACIOT', ftString, 50)]
    [Dictionary('MFC_HASHINTEGRADORACIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_HASHINTEGRADORACIOT: String read FMFC_HASHINTEGRADORACIOT write FMFC_HASHINTEGRADORACIOT;
    const MFC_HASHINTEGRADORACIOT_Name = 'MFC_HASHINTEGRADORACIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHSCHEMACIOT', ftString, 255)]
    [Dictionary('MFC_PATHSCHEMACIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHSCHEMACIOT: String read FMFC_PATHSCHEMACIOT write FMFC_PATHSCHEMACIOT;
    const MFC_PATHSCHEMACIOT_Name = 'MFC_PATHSCHEMACIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_PATHREPOSITORIOCIOT', ftString, 255)]
    [Dictionary('MFC_PATHREPOSITORIOCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PATHREPOSITORIOCIOT: String read FMFC_PATHREPOSITORIOCIOT write FMFC_PATHREPOSITORIOCIOT;
    const MFC_PATHREPOSITORIOCIOT_Name = 'MFC_PATHREPOSITORIOCIOT';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIEINTERESTADUAL', ftString, 3)]
    [Dictionary('CTR_SERIEINTERESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIEINTERESTADUAL: String read FCTR_SERIEINTERESTADUAL write FCTR_SERIEINTERESTADUAL;
    const CTR_SERIEINTERESTADUAL_Name = 'CTR_SERIEINTERESTADUAL';

    [Restrictions([NoValidate])]
    [Column('CTR_EMAILTLS', ftString, 1)]
    [Dictionary('CTR_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_EMAILTLS: String read FCTR_EMAILTLS write FCTR_EMAILTLS;
    const CTR_EMAILTLS_Name = 'CTR_EMAILTLS';

    [Restrictions([NoValidate])]
    [Column('MFC_EMAILTLS', ftString, 1)]
    [Dictionary('MFC_EMAILTLS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_EMAILTLS: String read FMFC_EMAILTLS write FMFC_EMAILTLS;
    const MFC_EMAILTLS_Name = 'MFC_EMAILTLS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONFIG_00_02)

end.
