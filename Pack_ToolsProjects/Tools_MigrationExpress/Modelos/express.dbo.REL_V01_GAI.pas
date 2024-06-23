unit express.dbo.REL_V01_GAI;

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
  [Table('REL_V01_GAI', '')]
  TDtoREL_V01_GAI = class
  private
    { Private declarations } 
    FGAI_CODIGO: Integer;
    FGAI_DESCRICAO: String;
    FGAI_DESATIVADO: String;
    FGAI_UF: String;
    FAQT_CODIGO_AC: Integer;
    FAQT_DESCRICAO_AC: String;
    FAQT_CODIGO_AL: Integer;
    FAQT_DESCRICAO_AL: String;
    FAQT_CODIGO_AP: Integer;
    FAQT_DESCRICAO_AP: String;
    FAQT_CODIGO_AM: Integer;
    FAQT_DESCRICAO_AM: String;
    FAQT_CODIGO_BA: Integer;
    FAQT_DESCRICAO_BA: String;
    FAQT_CODIGO_CE: Integer;
    FAQT_DESCRICAO_CE: String;
    FAQT_CODIGO_DF: Integer;
    FAQT_DESCRICAO_DF: String;
    FAQT_CODIGO_ES: Integer;
    FAQT_DESCRICAO_ES: String;
    FAQT_CODIGO_GO: Integer;
    FAQT_DESCRICAO_GO: String;
    FAQT_CODIGO_MA: Integer;
    FAQT_DESCRICAO_MA: String;
    FAQT_CODIGO_MT: Integer;
    FAQT_DESCRICAO_MT: String;
    FAQT_CODIGO_MS: Integer;
    FAQT_DESCRICAO_MS: String;
    FAQT_CODIGO_MG: Integer;
    FAQT_DESCRICAO_MG: String;
    FAQT_CODIGO_PA: Integer;
    FAQT_DESCRICAO_PA: String;
    FAQT_CODIGO_PB: Integer;
    FAQT_DESCRICAO_PB: String;
    FAQT_CODIGO_PR: Integer;
    FAQT_DESCRICAO_PR: String;
    FAQT_CODIGO_PE: Integer;
    FAQT_DESCRICAO_PE: String;
    FAQT_CODIGO_PI: Integer;
    FAQT_DESCRICAO_PI: String;
    FAQT_CODIGO_RN: Integer;
    FAQT_DESCRICAO_RN: String;
    FAQT_CODIGO_RS: Integer;
    FAQT_DESCRICAO_RS: String;
    FAQT_CODIGO_RJ: Integer;
    FAQT_DESCRICAO_RJ: String;
    FAQT_CODIGO_RO: Integer;
    FAQT_DESCRICAO_RO: String;
    FAQT_CODIGO_RR: Integer;
    FAQT_DESCRICAO_RR: String;
    FAQT_CODIGO_SC: Integer;
    FAQT_DESCRICAO_SC: String;
    FAQT_CODIGO_SP: Integer;
    FAQT_DESCRICAO_SP: String;
    FAQT_CODIGO_SE: Integer;
    FAQT_DESCRICAO_SE: String;
    FAQT_CODIGO_TO: Integer;
    FAQT_DESCRICAO_TO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_GAI';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DESCRICAO', ftString, 30)]
    [Dictionary('GAI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESCRICAO: String read FGAI_DESCRICAO write FGAI_DESCRICAO;
    const GAI_DESCRICAO_Name = 'GAI_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DESATIVADO', ftString, 1)]
    [Dictionary('GAI_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESATIVADO: String read FGAI_DESATIVADO write FGAI_DESATIVADO;
    const GAI_DESATIVADO_Name = 'GAI_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_UF', ftString, 2)]
    [Dictionary('GAI_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_UF: String read FGAI_UF write FGAI_UF;
    const GAI_UF_Name = 'GAI_UF';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_AC', ftInteger)]
    [Dictionary('AQT_CODIGO_AC', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AC: Integer read FAQT_CODIGO_AC write FAQT_CODIGO_AC;
    const AQT_CODIGO_AC_Name = 'AQT_CODIGO_AC';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_AC', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_AC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_AC: String read FAQT_DESCRICAO_AC write FAQT_DESCRICAO_AC;
    const AQT_DESCRICAO_AC_Name = 'AQT_DESCRICAO_AC';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_AL', ftInteger)]
    [Dictionary('AQT_CODIGO_AL', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AL: Integer read FAQT_CODIGO_AL write FAQT_CODIGO_AL;
    const AQT_CODIGO_AL_Name = 'AQT_CODIGO_AL';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_AL', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_AL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_AL: String read FAQT_DESCRICAO_AL write FAQT_DESCRICAO_AL;
    const AQT_DESCRICAO_AL_Name = 'AQT_DESCRICAO_AL';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_AP', ftInteger)]
    [Dictionary('AQT_CODIGO_AP', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AP: Integer read FAQT_CODIGO_AP write FAQT_CODIGO_AP;
    const AQT_CODIGO_AP_Name = 'AQT_CODIGO_AP';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_AP', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_AP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_AP: String read FAQT_DESCRICAO_AP write FAQT_DESCRICAO_AP;
    const AQT_DESCRICAO_AP_Name = 'AQT_DESCRICAO_AP';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_AM', ftInteger)]
    [Dictionary('AQT_CODIGO_AM', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AM: Integer read FAQT_CODIGO_AM write FAQT_CODIGO_AM;
    const AQT_CODIGO_AM_Name = 'AQT_CODIGO_AM';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_AM', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_AM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_AM: String read FAQT_DESCRICAO_AM write FAQT_DESCRICAO_AM;
    const AQT_DESCRICAO_AM_Name = 'AQT_DESCRICAO_AM';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_BA', ftInteger)]
    [Dictionary('AQT_CODIGO_BA', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_BA: Integer read FAQT_CODIGO_BA write FAQT_CODIGO_BA;
    const AQT_CODIGO_BA_Name = 'AQT_CODIGO_BA';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_BA', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_BA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_BA: String read FAQT_DESCRICAO_BA write FAQT_DESCRICAO_BA;
    const AQT_DESCRICAO_BA_Name = 'AQT_DESCRICAO_BA';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_CE', ftInteger)]
    [Dictionary('AQT_CODIGO_CE', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_CE: Integer read FAQT_CODIGO_CE write FAQT_CODIGO_CE;
    const AQT_CODIGO_CE_Name = 'AQT_CODIGO_CE';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_CE', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_CE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_CE: String read FAQT_DESCRICAO_CE write FAQT_DESCRICAO_CE;
    const AQT_DESCRICAO_CE_Name = 'AQT_DESCRICAO_CE';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_DF', ftInteger)]
    [Dictionary('AQT_CODIGO_DF', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_DF: Integer read FAQT_CODIGO_DF write FAQT_CODIGO_DF;
    const AQT_CODIGO_DF_Name = 'AQT_CODIGO_DF';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_DF', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_DF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_DF: String read FAQT_DESCRICAO_DF write FAQT_DESCRICAO_DF;
    const AQT_DESCRICAO_DF_Name = 'AQT_DESCRICAO_DF';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_ES', ftInteger)]
    [Dictionary('AQT_CODIGO_ES', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_ES: Integer read FAQT_CODIGO_ES write FAQT_CODIGO_ES;
    const AQT_CODIGO_ES_Name = 'AQT_CODIGO_ES';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_ES', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_ES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_ES: String read FAQT_DESCRICAO_ES write FAQT_DESCRICAO_ES;
    const AQT_DESCRICAO_ES_Name = 'AQT_DESCRICAO_ES';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_GO', ftInteger)]
    [Dictionary('AQT_CODIGO_GO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_GO: Integer read FAQT_CODIGO_GO write FAQT_CODIGO_GO;
    const AQT_CODIGO_GO_Name = 'AQT_CODIGO_GO';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_GO', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_GO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_GO: String read FAQT_DESCRICAO_GO write FAQT_DESCRICAO_GO;
    const AQT_DESCRICAO_GO_Name = 'AQT_DESCRICAO_GO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MA', ftInteger)]
    [Dictionary('AQT_CODIGO_MA', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MA: Integer read FAQT_CODIGO_MA write FAQT_CODIGO_MA;
    const AQT_CODIGO_MA_Name = 'AQT_CODIGO_MA';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_MA', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_MA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_MA: String read FAQT_DESCRICAO_MA write FAQT_DESCRICAO_MA;
    const AQT_DESCRICAO_MA_Name = 'AQT_DESCRICAO_MA';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MT', ftInteger)]
    [Dictionary('AQT_CODIGO_MT', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MT: Integer read FAQT_CODIGO_MT write FAQT_CODIGO_MT;
    const AQT_CODIGO_MT_Name = 'AQT_CODIGO_MT';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_MT', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_MT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_MT: String read FAQT_DESCRICAO_MT write FAQT_DESCRICAO_MT;
    const AQT_DESCRICAO_MT_Name = 'AQT_DESCRICAO_MT';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MS', ftInteger)]
    [Dictionary('AQT_CODIGO_MS', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MS: Integer read FAQT_CODIGO_MS write FAQT_CODIGO_MS;
    const AQT_CODIGO_MS_Name = 'AQT_CODIGO_MS';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_MS', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_MS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_MS: String read FAQT_DESCRICAO_MS write FAQT_DESCRICAO_MS;
    const AQT_DESCRICAO_MS_Name = 'AQT_DESCRICAO_MS';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MG', ftInteger)]
    [Dictionary('AQT_CODIGO_MG', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MG: Integer read FAQT_CODIGO_MG write FAQT_CODIGO_MG;
    const AQT_CODIGO_MG_Name = 'AQT_CODIGO_MG';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_MG', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_MG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_MG: String read FAQT_DESCRICAO_MG write FAQT_DESCRICAO_MG;
    const AQT_DESCRICAO_MG_Name = 'AQT_DESCRICAO_MG';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PA', ftInteger)]
    [Dictionary('AQT_CODIGO_PA', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PA: Integer read FAQT_CODIGO_PA write FAQT_CODIGO_PA;
    const AQT_CODIGO_PA_Name = 'AQT_CODIGO_PA';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_PA', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_PA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_PA: String read FAQT_DESCRICAO_PA write FAQT_DESCRICAO_PA;
    const AQT_DESCRICAO_PA_Name = 'AQT_DESCRICAO_PA';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PB', ftInteger)]
    [Dictionary('AQT_CODIGO_PB', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PB: Integer read FAQT_CODIGO_PB write FAQT_CODIGO_PB;
    const AQT_CODIGO_PB_Name = 'AQT_CODIGO_PB';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_PB', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_PB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_PB: String read FAQT_DESCRICAO_PB write FAQT_DESCRICAO_PB;
    const AQT_DESCRICAO_PB_Name = 'AQT_DESCRICAO_PB';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PR', ftInteger)]
    [Dictionary('AQT_CODIGO_PR', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PR: Integer read FAQT_CODIGO_PR write FAQT_CODIGO_PR;
    const AQT_CODIGO_PR_Name = 'AQT_CODIGO_PR';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_PR', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_PR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_PR: String read FAQT_DESCRICAO_PR write FAQT_DESCRICAO_PR;
    const AQT_DESCRICAO_PR_Name = 'AQT_DESCRICAO_PR';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PE', ftInteger)]
    [Dictionary('AQT_CODIGO_PE', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PE: Integer read FAQT_CODIGO_PE write FAQT_CODIGO_PE;
    const AQT_CODIGO_PE_Name = 'AQT_CODIGO_PE';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_PE', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_PE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_PE: String read FAQT_DESCRICAO_PE write FAQT_DESCRICAO_PE;
    const AQT_DESCRICAO_PE_Name = 'AQT_DESCRICAO_PE';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PI', ftInteger)]
    [Dictionary('AQT_CODIGO_PI', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PI: Integer read FAQT_CODIGO_PI write FAQT_CODIGO_PI;
    const AQT_CODIGO_PI_Name = 'AQT_CODIGO_PI';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_PI', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_PI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_PI: String read FAQT_DESCRICAO_PI write FAQT_DESCRICAO_PI;
    const AQT_DESCRICAO_PI_Name = 'AQT_DESCRICAO_PI';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RN', ftInteger)]
    [Dictionary('AQT_CODIGO_RN', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RN: Integer read FAQT_CODIGO_RN write FAQT_CODIGO_RN;
    const AQT_CODIGO_RN_Name = 'AQT_CODIGO_RN';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_RN', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_RN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_RN: String read FAQT_DESCRICAO_RN write FAQT_DESCRICAO_RN;
    const AQT_DESCRICAO_RN_Name = 'AQT_DESCRICAO_RN';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RS', ftInteger)]
    [Dictionary('AQT_CODIGO_RS', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RS: Integer read FAQT_CODIGO_RS write FAQT_CODIGO_RS;
    const AQT_CODIGO_RS_Name = 'AQT_CODIGO_RS';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_RS', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_RS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_RS: String read FAQT_DESCRICAO_RS write FAQT_DESCRICAO_RS;
    const AQT_DESCRICAO_RS_Name = 'AQT_DESCRICAO_RS';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RJ', ftInteger)]
    [Dictionary('AQT_CODIGO_RJ', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RJ: Integer read FAQT_CODIGO_RJ write FAQT_CODIGO_RJ;
    const AQT_CODIGO_RJ_Name = 'AQT_CODIGO_RJ';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_RJ', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_RJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_RJ: String read FAQT_DESCRICAO_RJ write FAQT_DESCRICAO_RJ;
    const AQT_DESCRICAO_RJ_Name = 'AQT_DESCRICAO_RJ';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RO', ftInteger)]
    [Dictionary('AQT_CODIGO_RO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RO: Integer read FAQT_CODIGO_RO write FAQT_CODIGO_RO;
    const AQT_CODIGO_RO_Name = 'AQT_CODIGO_RO';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_RO', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_RO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_RO: String read FAQT_DESCRICAO_RO write FAQT_DESCRICAO_RO;
    const AQT_DESCRICAO_RO_Name = 'AQT_DESCRICAO_RO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RR', ftInteger)]
    [Dictionary('AQT_CODIGO_RR', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RR: Integer read FAQT_CODIGO_RR write FAQT_CODIGO_RR;
    const AQT_CODIGO_RR_Name = 'AQT_CODIGO_RR';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_RR', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_RR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_RR: String read FAQT_DESCRICAO_RR write FAQT_DESCRICAO_RR;
    const AQT_DESCRICAO_RR_Name = 'AQT_DESCRICAO_RR';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_SC', ftInteger)]
    [Dictionary('AQT_CODIGO_SC', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_SC: Integer read FAQT_CODIGO_SC write FAQT_CODIGO_SC;
    const AQT_CODIGO_SC_Name = 'AQT_CODIGO_SC';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_SC', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_SC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_SC: String read FAQT_DESCRICAO_SC write FAQT_DESCRICAO_SC;
    const AQT_DESCRICAO_SC_Name = 'AQT_DESCRICAO_SC';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_SP', ftInteger)]
    [Dictionary('AQT_CODIGO_SP', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_SP: Integer read FAQT_CODIGO_SP write FAQT_CODIGO_SP;
    const AQT_CODIGO_SP_Name = 'AQT_CODIGO_SP';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_SP', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_SP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_SP: String read FAQT_DESCRICAO_SP write FAQT_DESCRICAO_SP;
    const AQT_DESCRICAO_SP_Name = 'AQT_DESCRICAO_SP';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_SE', ftInteger)]
    [Dictionary('AQT_CODIGO_SE', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_SE: Integer read FAQT_CODIGO_SE write FAQT_CODIGO_SE;
    const AQT_CODIGO_SE_Name = 'AQT_CODIGO_SE';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_SE', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_SE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_SE: String read FAQT_DESCRICAO_SE write FAQT_DESCRICAO_SE;
    const AQT_DESCRICAO_SE_Name = 'AQT_DESCRICAO_SE';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_TO', ftInteger)]
    [Dictionary('AQT_CODIGO_TO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_TO: Integer read FAQT_CODIGO_TO write FAQT_CODIGO_TO;
    const AQT_CODIGO_TO_Name = 'AQT_CODIGO_TO';

    [Restrictions([NoValidate])]
    [Column('AQT_DESCRICAO_TO', ftString, 30)]
    [Dictionary('AQT_DESCRICAO_TO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO_TO: String read FAQT_DESCRICAO_TO write FAQT_DESCRICAO_TO;
    const AQT_DESCRICAO_TO_Name = 'AQT_DESCRICAO_TO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_GAI)

end.
