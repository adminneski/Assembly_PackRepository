unit express.dbo.BCP_00;

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
  [Table('BCP_00', '')]
  [PrimaryKey('BCP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCP_ID')]
  TDtoBCP_00 = class
  private
    { Private declarations } 
    FBCP_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FBCP_HISTORICO: String;
    FBCP_PROCESSADO: String;
    FBCP_OBSERVACAO: String;
    FBCP_TOTALDINHEIROLOTE: Double;
    FBCP_TOTALCHEQUELOTE: Double;
    FBCP_DATALANCAMENTO: TDateTime;
    FCRE_TOTALVALORLOTE: Double;
    FCRE_TOTALJUROSLOTE: Double;
    FCRE_TOTALMULTALOTE: Double;
    FCRE_TOTALDESCTOLOTE: Double;
    FCRE_TOTALCARTORIOLOTE: Double;
    FCRE_TOTALOUTRASDESPESASLOTE: Double;
    FCRE_TOTALVALORBAIXALOTE: Double;
    FCPA_TOTALVALORLOTE: Double;
    FCPA_TOTALJUROSLOTE: Double;
    FCPA_TOTALMULTALOTE: Double;
    FCPA_TOTALDESCTOLOTE: Double;
    FCPA_TOTALOUTRASDESPESASLOTE: Double;
    FCPA_TOTALVALORBAIXALOTE: Double;
    FBCP_DATAALTERACAO: TDateTime;
    FBCP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'BCP_00';
     const PrimaryKey = 'BCP_ID';
     const Sequence   = 'SEQ_BCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_ID', ftInteger)]
    [Dictionary('BCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID: Integer read FBCP_ID write FBCP_ID;
    const BCP_ID_Name = 'BCP_ID';

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
    [Column('BCP_HISTORICO', ftString, 300)]
    [Dictionary('BCP_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCP_HISTORICO: String read FBCP_HISTORICO write FBCP_HISTORICO;
    const BCP_HISTORICO_Name = 'BCP_HISTORICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_PROCESSADO', ftString, 1)]
    [Dictionary('BCP_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCP_PROCESSADO: String read FBCP_PROCESSADO write FBCP_PROCESSADO;
    const BCP_PROCESSADO_Name = 'BCP_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('BCP_OBSERVACAO', ftString, 300)]
    [Dictionary('BCP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCP_OBSERVACAO: String read FBCP_OBSERVACAO write FBCP_OBSERVACAO;
    const BCP_OBSERVACAO_Name = 'BCP_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_TOTALDINHEIROLOTE', ftBCD)]
    [Dictionary('BCP_TOTALDINHEIROLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCP_TOTALDINHEIROLOTE: Double read FBCP_TOTALDINHEIROLOTE write FBCP_TOTALDINHEIROLOTE;
    const BCP_TOTALDINHEIROLOTE_Name = 'BCP_TOTALDINHEIROLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_TOTALCHEQUELOTE', ftBCD)]
    [Dictionary('BCP_TOTALCHEQUELOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCP_TOTALCHEQUELOTE: Double read FBCP_TOTALCHEQUELOTE write FBCP_TOTALCHEQUELOTE;
    const BCP_TOTALCHEQUELOTE_Name = 'BCP_TOTALCHEQUELOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCP_DATALANCAMENTO: TDateTime read FBCP_DATALANCAMENTO write FBCP_DATALANCAMENTO;
    const BCP_DATALANCAMENTO_Name = 'BCP_DATALANCAMENTO';

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
    [Column('CRE_TOTALOUTRASDESPESASLOTE', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESASLOTE: Double read FCRE_TOTALOUTRASDESPESASLOTE write FCRE_TOTALOUTRASDESPESASLOTE;
    const CRE_TOTALOUTRASDESPESASLOTE_Name = 'CRE_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXALOTE', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXALOTE: Double read FCRE_TOTALVALORBAIXALOTE write FCRE_TOTALVALORBAIXALOTE;
    const CRE_TOTALVALORBAIXALOTE_Name = 'CRE_TOTALVALORBAIXALOTE';

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
    [Column('CPA_TOTALOUTRASDESPESASLOTE', ftBCD)]
    [Dictionary('CPA_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESASLOTE: Double read FCPA_TOTALOUTRASDESPESASLOTE write FCPA_TOTALOUTRASDESPESASLOTE;
    const CPA_TOTALOUTRASDESPESASLOTE_Name = 'CPA_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALORBAIXALOTE', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXALOTE: Double read FCPA_TOTALVALORBAIXALOTE write FCPA_TOTALVALORBAIXALOTE;
    const CPA_TOTALVALORBAIXALOTE_Name = 'CPA_TOTALVALORBAIXALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCP_DATAALTERACAO: TDateTime read FBCP_DATAALTERACAO write FBCP_DATAALTERACAO;
    const BCP_DATAALTERACAO_Name = 'BCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCP_ID_OLD', ftInteger)]
    [Dictionary('BCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID_OLD: Integer read FBCP_ID_OLD write FBCP_ID_OLD;
    const BCP_ID_OLD_Name = 'BCP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCP_00)

end.
