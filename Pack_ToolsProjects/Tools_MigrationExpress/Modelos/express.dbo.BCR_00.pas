unit express.dbo.BCR_00;

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
  [Table('BCR_00', '')]
  [PrimaryKey('BCR_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCR_ID')]
  TDtoBCR_00 = class
  private
    { Private declarations } 
    FBCR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FBCR_HISTORICO: String;
    FBCR_OBSERVACAO: String;
    FBCR_PROCESSADO: String;
    FBCR_TIPODOCUMENTO: String;
    FBCR_TIPORATEIOCARTAO: String;
    FBCR_DATALANCAMENTO: TDateTime;
    FCRE_TOTALVALORLOTE: Double;
    FCRE_TOTALJUROSLOTE: Double;
    FCRE_TOTALMULTALOTE: Double;
    FCRE_TOTALDESCTOLOTE: Double;
    FCRE_TOTALCARTORIOLOTE: Double;
    FCRE_TOTALVALORBAIXALOTE: Double;
    FCRE_TOTALOUTRASDESPESASLOTE: Double;
    FCPA_TOTALVALORLOTE: Double;
    FCPA_TOTALJUROSLOTE: Double;
    FCPA_TOTALMULTALOTE: Double;
    FCPA_TOTALDESCTOLOTE: Double;
    FCPA_TOTALVALORBAIXALOTE: Double;
    FCPA_TOTALOUTRASDESPESASLOTE: Double;
    FCRE_TOTALFINANCEIROLOTE: Double;
    FBCR_DATAALTERACAO: TDateTime;
    FBCR_TIPOMOVTO: String;
    FPES_CODIGO: Integer;
    FUSERS_LOGIN: String;
    FBCR_TIPOBAIXA: String;
    FBCR_CAMINHOARQRETORNO: String;
    FCRE_TOTALTARIFABANCARIALOTE: Double;
    FBCR_ID_OLD: Integer;
    FBCR_TIPOPROCESSAMENTO: String;
  public 
    { Public declarations } 
     const Table      = 'BCR_00';
     const PrimaryKey = 'BCR_ID';
     const Sequence   = 'SEQ_BCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_ID', ftInteger)]
    [Dictionary('BCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCR_ID: Integer read FBCR_ID write FBCR_ID;
    const BCR_ID_Name = 'BCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCR_HISTORICO', ftString, 5000)]
    [Dictionary('BCR_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_HISTORICO: String read FBCR_HISTORICO write FBCR_HISTORICO;
    const BCR_HISTORICO_Name = 'BCR_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('BCR_OBSERVACAO', ftString, 5000)]
    [Dictionary('BCR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_OBSERVACAO: String read FBCR_OBSERVACAO write FBCR_OBSERVACAO;
    const BCR_OBSERVACAO_Name = 'BCR_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_PROCESSADO', ftString, 1)]
    [Dictionary('BCR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_PROCESSADO: String read FBCR_PROCESSADO write FBCR_PROCESSADO;
    const BCR_PROCESSADO_Name = 'BCR_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('BCR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_TIPODOCUMENTO: String read FBCR_TIPODOCUMENTO write FBCR_TIPODOCUMENTO;
    const BCR_TIPODOCUMENTO_Name = 'BCR_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('BCR_TIPORATEIOCARTAO', ftString, 1)]
    [Dictionary('BCR_TIPORATEIOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_TIPORATEIOCARTAO: String read FBCR_TIPORATEIOCARTAO write FBCR_TIPORATEIOCARTAO;
    const BCR_TIPORATEIOCARTAO_Name = 'BCR_TIPORATEIOCARTAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCR_DATALANCAMENTO: TDateTime read FBCR_DATALANCAMENTO write FBCR_DATALANCAMENTO;
    const BCR_DATALANCAMENTO_Name = 'BCR_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORLOTE', ftBCD)]
    [Dictionary('CRE_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORLOTE: Double read FCRE_TOTALVALORLOTE write FCRE_TOTALVALORLOTE;
    const CRE_TOTALVALORLOTE_Name = 'CRE_TOTALVALORLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROSLOTE', ftBCD)]
    [Dictionary('CRE_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROSLOTE: Double read FCRE_TOTALJUROSLOTE write FCRE_TOTALJUROSLOTE;
    const CRE_TOTALJUROSLOTE_Name = 'CRE_TOTALJUROSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTALOTE', ftBCD)]
    [Dictionary('CRE_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTALOTE: Double read FCRE_TOTALMULTALOTE write FCRE_TOTALMULTALOTE;
    const CRE_TOTALMULTALOTE_Name = 'CRE_TOTALMULTALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTOLOTE', ftBCD)]
    [Dictionary('CRE_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTOLOTE: Double read FCRE_TOTALDESCTOLOTE write FCRE_TOTALDESCTOLOTE;
    const CRE_TOTALDESCTOLOTE_Name = 'CRE_TOTALDESCTOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIOLOTE', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIOLOTE: Double read FCRE_TOTALCARTORIOLOTE write FCRE_TOTALCARTORIOLOTE;
    const CRE_TOTALCARTORIOLOTE_Name = 'CRE_TOTALCARTORIOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXALOTE', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXALOTE: Double read FCRE_TOTALVALORBAIXALOTE write FCRE_TOTALVALORBAIXALOTE;
    const CRE_TOTALVALORBAIXALOTE_Name = 'CRE_TOTALVALORBAIXALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESASLOTE', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESASLOTE: Double read FCRE_TOTALOUTRASDESPESASLOTE write FCRE_TOTALOUTRASDESPESASLOTE;
    const CRE_TOTALOUTRASDESPESASLOTE_Name = 'CRE_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALORLOTE', ftBCD)]
    [Dictionary('CPA_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORLOTE: Double read FCPA_TOTALVALORLOTE write FCPA_TOTALVALORLOTE;
    const CPA_TOTALVALORLOTE_Name = 'CPA_TOTALVALORLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALJUROSLOTE', ftBCD)]
    [Dictionary('CPA_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROSLOTE: Double read FCPA_TOTALJUROSLOTE write FCPA_TOTALJUROSLOTE;
    const CPA_TOTALJUROSLOTE_Name = 'CPA_TOTALJUROSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALMULTALOTE', ftBCD)]
    [Dictionary('CPA_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTALOTE: Double read FCPA_TOTALMULTALOTE write FCPA_TOTALMULTALOTE;
    const CPA_TOTALMULTALOTE_Name = 'CPA_TOTALMULTALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALDESCTOLOTE', ftBCD)]
    [Dictionary('CPA_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTOLOTE: Double read FCPA_TOTALDESCTOLOTE write FCPA_TOTALDESCTOLOTE;
    const CPA_TOTALDESCTOLOTE_Name = 'CPA_TOTALDESCTOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALORBAIXALOTE', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXALOTE: Double read FCPA_TOTALVALORBAIXALOTE write FCPA_TOTALVALORBAIXALOTE;
    const CPA_TOTALVALORBAIXALOTE_Name = 'CPA_TOTALVALORBAIXALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALOUTRASDESPESASLOTE', ftBCD)]
    [Dictionary('CPA_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESASLOTE: Double read FCPA_TOTALOUTRASDESPESASLOTE write FCPA_TOTALOUTRASDESPESASLOTE;
    const CPA_TOTALOUTRASDESPESASLOTE_Name = 'CPA_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFINANCEIROLOTE', ftBCD)]
    [Dictionary('CRE_TOTALFINANCEIROLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFINANCEIROLOTE: Double read FCRE_TOTALFINANCEIROLOTE write FCRE_TOTALFINANCEIROLOTE;
    const CRE_TOTALFINANCEIROLOTE_Name = 'CRE_TOTALFINANCEIROLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCR_DATAALTERACAO: TDateTime read FBCR_DATAALTERACAO write FBCR_DATAALTERACAO;
    const BCR_DATAALTERACAO_Name = 'BCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCR_TIPOMOVTO', ftString, 3)]
    [Dictionary('BCR_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_TIPOMOVTO: String read FBCR_TIPOMOVTO write FBCR_TIPOMOVTO;
    const BCR_TIPOMOVTO_Name = 'BCR_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('BCR_TIPOBAIXA', ftString, 1)]
    [Dictionary('BCR_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_TIPOBAIXA: String read FBCR_TIPOBAIXA write FBCR_TIPOBAIXA;
    const BCR_TIPOBAIXA_Name = 'BCR_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('BCR_CAMINHOARQRETORNO', ftString, 300)]
    [Dictionary('BCR_CAMINHOARQRETORNO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_CAMINHOARQRETORNO: String read FBCR_CAMINHOARQRETORNO write FBCR_CAMINHOARQRETORNO;
    const BCR_CAMINHOARQRETORNO_Name = 'BCR_CAMINHOARQRETORNO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALTARIFABANCARIALOTE', ftBCD)]
    [Dictionary('CRE_TOTALTARIFABANCARIALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALTARIFABANCARIALOTE: Double read FCRE_TOTALTARIFABANCARIALOTE write FCRE_TOTALTARIFABANCARIALOTE;
    const CRE_TOTALTARIFABANCARIALOTE_Name = 'CRE_TOTALTARIFABANCARIALOTE';

    [Restrictions([NoValidate])]
    [Column('BCR_ID_OLD', ftInteger)]
    [Dictionary('BCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCR_ID_OLD: Integer read FBCR_ID_OLD write FBCR_ID_OLD;
    const BCR_ID_OLD_Name = 'BCR_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCR_TIPOPROCESSAMENTO', ftString, 1)]
    [Dictionary('BCR_TIPOPROCESSAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_TIPOPROCESSAMENTO: String read FBCR_TIPOPROCESSAMENTO write FBCR_TIPOPROCESSAMENTO;
    const BCR_TIPOPROCESSAMENTO_Name = 'BCR_TIPOPROCESSAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCR_00)

end.
