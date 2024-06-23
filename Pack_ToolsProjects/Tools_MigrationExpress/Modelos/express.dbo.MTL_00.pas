unit express.dbo.MTL_00;

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
  [Table('MTL_00', '')]
  [PrimaryKey('MTL_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MTL_ID')]
  TDtoMTL_00 = class
  private
    { Private declarations } 
    FMTL_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FMTL_HISTORICO: String;
    FMTL_DATABAIXA: TDateTime;
    FMTL_DATALANCAMENTO: TDateTime;
    FMTL_TOTALTALONARIOLOTE: Double;
    FMTL_TOTALCONTAPAGARLOTE: Double;
    FCPA_TOTALVALORLOTE: Double;
    FCPA_TOTALJUROSLOTE: Double;
    FCPA_TOTALMULTALOTE: Double;
    FCPA_TOTALDESCTOLOTE: Double;
    FCPA_TOTALOUTRASDESPESASLOTE: Double;
    FMTL_OBSERVACAO: String;
    FMTL_VINCULADO: String;
    FMTL_PROCESSADO: String;
    FMTL_DATAALTERACAO: TDateTime;
    FMTL_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'MTL_00';
     const PrimaryKey = 'MTL_ID';
     const Sequence   = 'SEQ_MTL_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_ID', ftInteger)]
    [Dictionary('MTL_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_ID: Integer read FMTL_ID write FMTL_ID;
    const MTL_ID_Name = 'MTL_ID';

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
    [Column('MTL_HISTORICO', ftString, 300)]
    [Dictionary('MTL_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTL_HISTORICO: String read FMTL_HISTORICO write FMTL_HISTORICO;
    const MTL_HISTORICO_Name = 'MTL_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('MTL_DATABAIXA', ftDateTime)]
    [Dictionary('MTL_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property MTL_DATABAIXA: TDateTime read FMTL_DATABAIXA write FMTL_DATABAIXA;
    const MTL_DATABAIXA_Name = 'MTL_DATABAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MTL_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTL_DATALANCAMENTO: TDateTime read FMTL_DATALANCAMENTO write FMTL_DATALANCAMENTO;
    const MTL_DATALANCAMENTO_Name = 'MTL_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_TOTALTALONARIOLOTE', ftBCD)]
    [Dictionary('MTL_TOTALTALONARIOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MTL_TOTALTALONARIOLOTE: Double read FMTL_TOTALTALONARIOLOTE write FMTL_TOTALTALONARIOLOTE;
    const MTL_TOTALTALONARIOLOTE_Name = 'MTL_TOTALTALONARIOLOTE';

    [Restrictions([NoValidate])]
    [Column('MTL_TOTALCONTAPAGARLOTE', ftBCD)]
    [Dictionary('MTL_TOTALCONTAPAGARLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MTL_TOTALCONTAPAGARLOTE: Double read FMTL_TOTALCONTAPAGARLOTE write FMTL_TOTALCONTAPAGARLOTE;
    const MTL_TOTALCONTAPAGARLOTE_Name = 'MTL_TOTALCONTAPAGARLOTE';

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

    [Restrictions([NoValidate])]
    [Column('MTL_OBSERVACAO', ftString, 300)]
    [Dictionary('MTL_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTL_OBSERVACAO: String read FMTL_OBSERVACAO write FMTL_OBSERVACAO;
    const MTL_OBSERVACAO_Name = 'MTL_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_VINCULADO', ftString, 1)]
    [Dictionary('MTL_VINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTL_VINCULADO: String read FMTL_VINCULADO write FMTL_VINCULADO;
    const MTL_VINCULADO_Name = 'MTL_VINCULADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_PROCESSADO', ftString, 1)]
    [Dictionary('MTL_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTL_PROCESSADO: String read FMTL_PROCESSADO write FMTL_PROCESSADO;
    const MTL_PROCESSADO_Name = 'MTL_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_DATAALTERACAO', ftDateTime)]
    [Dictionary('MTL_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTL_DATAALTERACAO: TDateTime read FMTL_DATAALTERACAO write FMTL_DATAALTERACAO;
    const MTL_DATAALTERACAO_Name = 'MTL_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MTL_ID_OLD', ftInteger)]
    [Dictionary('MTL_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_ID_OLD: Integer read FMTL_ID_OLD write FMTL_ID_OLD;
    const MTL_ID_OLD_Name = 'MTL_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMTL_00)

end.
