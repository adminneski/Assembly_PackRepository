unit express.dbo.GAI_00;

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
  [Table('GAI_00', '')]
  [PrimaryKey('GAI_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_GAI_CODIGO')]
  TDtoGAI_00 = class
  private
    { Private declarations } 
    FGAI_CODIGO: Integer;
    FGAI_DESCRICAO: String;
    FGAI_UF: String;
    FAQT_CODIGO_AC: Integer;
    FAQT_CODIGO_AL: Integer;
    FAQT_CODIGO_AP: Integer;
    FAQT_CODIGO_AM: Integer;
    FAQT_CODIGO_BA: Integer;
    FAQT_CODIGO_CE: Integer;
    FAQT_CODIGO_DF: Integer;
    FAQT_CODIGO_ES: Integer;
    FAQT_CODIGO_GO: Integer;
    FAQT_CODIGO_MA: Integer;
    FAQT_CODIGO_MT: Integer;
    FAQT_CODIGO_MS: Integer;
    FAQT_CODIGO_MG: Integer;
    FAQT_CODIGO_PA: Integer;
    FAQT_CODIGO_PB: Integer;
    FAQT_CODIGO_PR: Integer;
    FAQT_CODIGO_PE: Integer;
    FAQT_CODIGO_PI: Integer;
    FAQT_CODIGO_RN: Integer;
    FAQT_CODIGO_RS: Integer;
    FAQT_CODIGO_RJ: Integer;
    FAQT_CODIGO_RO: Integer;
    FAQT_CODIGO_RR: Integer;
    FAQT_CODIGO_SC: Integer;
    FAQT_CODIGO_SP: Integer;
    FAQT_CODIGO_SE: Integer;
    FAQT_CODIGO_TO: Integer;
    FAQT_CODIGO_EX: Integer;
    FGAI_DATAALTERACAO: TDateTime;
    FGAI_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'GAI_00';
     const PrimaryKey = 'GAI_CODIGO';
     const Sequence   = 'SEQ_GAI_CODIGO';

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
    [Column('AQT_CODIGO_AL', ftInteger)]
    [Dictionary('AQT_CODIGO_AL', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AL: Integer read FAQT_CODIGO_AL write FAQT_CODIGO_AL;
    const AQT_CODIGO_AL_Name = 'AQT_CODIGO_AL';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_AP', ftInteger)]
    [Dictionary('AQT_CODIGO_AP', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AP: Integer read FAQT_CODIGO_AP write FAQT_CODIGO_AP;
    const AQT_CODIGO_AP_Name = 'AQT_CODIGO_AP';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_AM', ftInteger)]
    [Dictionary('AQT_CODIGO_AM', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_AM: Integer read FAQT_CODIGO_AM write FAQT_CODIGO_AM;
    const AQT_CODIGO_AM_Name = 'AQT_CODIGO_AM';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_BA', ftInteger)]
    [Dictionary('AQT_CODIGO_BA', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_BA: Integer read FAQT_CODIGO_BA write FAQT_CODIGO_BA;
    const AQT_CODIGO_BA_Name = 'AQT_CODIGO_BA';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_CE', ftInteger)]
    [Dictionary('AQT_CODIGO_CE', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_CE: Integer read FAQT_CODIGO_CE write FAQT_CODIGO_CE;
    const AQT_CODIGO_CE_Name = 'AQT_CODIGO_CE';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_DF', ftInteger)]
    [Dictionary('AQT_CODIGO_DF', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_DF: Integer read FAQT_CODIGO_DF write FAQT_CODIGO_DF;
    const AQT_CODIGO_DF_Name = 'AQT_CODIGO_DF';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_ES', ftInteger)]
    [Dictionary('AQT_CODIGO_ES', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_ES: Integer read FAQT_CODIGO_ES write FAQT_CODIGO_ES;
    const AQT_CODIGO_ES_Name = 'AQT_CODIGO_ES';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_GO', ftInteger)]
    [Dictionary('AQT_CODIGO_GO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_GO: Integer read FAQT_CODIGO_GO write FAQT_CODIGO_GO;
    const AQT_CODIGO_GO_Name = 'AQT_CODIGO_GO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MA', ftInteger)]
    [Dictionary('AQT_CODIGO_MA', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MA: Integer read FAQT_CODIGO_MA write FAQT_CODIGO_MA;
    const AQT_CODIGO_MA_Name = 'AQT_CODIGO_MA';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MT', ftInteger)]
    [Dictionary('AQT_CODIGO_MT', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MT: Integer read FAQT_CODIGO_MT write FAQT_CODIGO_MT;
    const AQT_CODIGO_MT_Name = 'AQT_CODIGO_MT';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MS', ftInteger)]
    [Dictionary('AQT_CODIGO_MS', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MS: Integer read FAQT_CODIGO_MS write FAQT_CODIGO_MS;
    const AQT_CODIGO_MS_Name = 'AQT_CODIGO_MS';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_MG', ftInteger)]
    [Dictionary('AQT_CODIGO_MG', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_MG: Integer read FAQT_CODIGO_MG write FAQT_CODIGO_MG;
    const AQT_CODIGO_MG_Name = 'AQT_CODIGO_MG';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PA', ftInteger)]
    [Dictionary('AQT_CODIGO_PA', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PA: Integer read FAQT_CODIGO_PA write FAQT_CODIGO_PA;
    const AQT_CODIGO_PA_Name = 'AQT_CODIGO_PA';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PB', ftInteger)]
    [Dictionary('AQT_CODIGO_PB', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PB: Integer read FAQT_CODIGO_PB write FAQT_CODIGO_PB;
    const AQT_CODIGO_PB_Name = 'AQT_CODIGO_PB';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PR', ftInteger)]
    [Dictionary('AQT_CODIGO_PR', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PR: Integer read FAQT_CODIGO_PR write FAQT_CODIGO_PR;
    const AQT_CODIGO_PR_Name = 'AQT_CODIGO_PR';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PE', ftInteger)]
    [Dictionary('AQT_CODIGO_PE', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PE: Integer read FAQT_CODIGO_PE write FAQT_CODIGO_PE;
    const AQT_CODIGO_PE_Name = 'AQT_CODIGO_PE';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_PI', ftInteger)]
    [Dictionary('AQT_CODIGO_PI', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_PI: Integer read FAQT_CODIGO_PI write FAQT_CODIGO_PI;
    const AQT_CODIGO_PI_Name = 'AQT_CODIGO_PI';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RN', ftInteger)]
    [Dictionary('AQT_CODIGO_RN', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RN: Integer read FAQT_CODIGO_RN write FAQT_CODIGO_RN;
    const AQT_CODIGO_RN_Name = 'AQT_CODIGO_RN';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RS', ftInteger)]
    [Dictionary('AQT_CODIGO_RS', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RS: Integer read FAQT_CODIGO_RS write FAQT_CODIGO_RS;
    const AQT_CODIGO_RS_Name = 'AQT_CODIGO_RS';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RJ', ftInteger)]
    [Dictionary('AQT_CODIGO_RJ', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RJ: Integer read FAQT_CODIGO_RJ write FAQT_CODIGO_RJ;
    const AQT_CODIGO_RJ_Name = 'AQT_CODIGO_RJ';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RO', ftInteger)]
    [Dictionary('AQT_CODIGO_RO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RO: Integer read FAQT_CODIGO_RO write FAQT_CODIGO_RO;
    const AQT_CODIGO_RO_Name = 'AQT_CODIGO_RO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_RR', ftInteger)]
    [Dictionary('AQT_CODIGO_RR', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_RR: Integer read FAQT_CODIGO_RR write FAQT_CODIGO_RR;
    const AQT_CODIGO_RR_Name = 'AQT_CODIGO_RR';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_SC', ftInteger)]
    [Dictionary('AQT_CODIGO_SC', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_SC: Integer read FAQT_CODIGO_SC write FAQT_CODIGO_SC;
    const AQT_CODIGO_SC_Name = 'AQT_CODIGO_SC';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_SP', ftInteger)]
    [Dictionary('AQT_CODIGO_SP', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_SP: Integer read FAQT_CODIGO_SP write FAQT_CODIGO_SP;
    const AQT_CODIGO_SP_Name = 'AQT_CODIGO_SP';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_SE', ftInteger)]
    [Dictionary('AQT_CODIGO_SE', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_SE: Integer read FAQT_CODIGO_SE write FAQT_CODIGO_SE;
    const AQT_CODIGO_SE_Name = 'AQT_CODIGO_SE';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_TO', ftInteger)]
    [Dictionary('AQT_CODIGO_TO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_TO: Integer read FAQT_CODIGO_TO write FAQT_CODIGO_TO;
    const AQT_CODIGO_TO_Name = 'AQT_CODIGO_TO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO_EX', ftInteger)]
    [Dictionary('AQT_CODIGO_EX', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO_EX: Integer read FAQT_CODIGO_EX write FAQT_CODIGO_EX;
    const AQT_CODIGO_EX_Name = 'AQT_CODIGO_EX';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DATAALTERACAO', ftDateTime)]
    [Dictionary('GAI_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property GAI_DATAALTERACAO: TDateTime read FGAI_DATAALTERACAO write FGAI_DATAALTERACAO;
    const GAI_DATAALTERACAO_Name = 'GAI_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GAI_DESATIVADO', ftString, 1)]
    [Dictionary('GAI_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESATIVADO: String read FGAI_DESATIVADO write FGAI_DESATIVADO;
    const GAI_DESATIVADO_Name = 'GAI_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGAI_00)

end.
