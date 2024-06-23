unit express.dbo.SCR_00;

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
  [Table('SCR_00', '')]
  [PrimaryKey('SCR_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCR_ID')]
  TDtoSCR_00 = class
  private
    { Private declarations } 
    FSCR_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FSCR_DATALANCAMENTO: TDateTime;
    FSCR_TIPODOCUMENTO: String;
    FCRE_TOTALVALORLOTE: Double;
    FCRE_TOTALJUROSLOTE: Double;
    FCRE_TOTALMULTALOTE: Double;
    FCRE_TOTALDESCTOLOTE: Double;
    FCRE_TOTALCARTORIOLOTE: Double;
    FCRE_TOTALOUTRASDESPESASLOTE: Double;
    FSCR_TOTALVALORSUBSTITUIDO: Double;
    FSCR_TOTALVALORSUBSTITUTO: Double;
    FSCR_TOTALCARTAOSUBSTITUTO: Double;
    FSCR_TOTALCHEQUESUBSTITUTO: Double;
    FSCR_PLANOCONTARATEIO: Double;
    FSCR_TOTALBASECOMISSAOLOTE: Double;
    FCRE_TOTALCOMISSAOLOTE: Double;
    FSCR_PERCENTUALCOMISSAO: Double;
    FSCR_HISTORICO: String;
    FSCR_OBSERVACAO: String;
    FSCR_PROCESSADO: String;
    FUSERS_LOGIN: String;
    FSCR_DATAALTERACAO: TDateTime;
    FSCR_PES_CODIGO: Integer;
    FSCR_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'SCR_00';
     const PrimaryKey = 'SCR_ID';
     const Sequence   = 'SEQ_SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATALANCAMENTO: TDateTime read FSCR_DATALANCAMENTO write FSCR_DATALANCAMENTO;
    const SCR_DATALANCAMENTO_Name = 'SCR_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('SCR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_TIPODOCUMENTO: String read FSCR_TIPODOCUMENTO write FSCR_TIPODOCUMENTO;
    const SCR_TIPODOCUMENTO_Name = 'SCR_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORLOTE', ftBCD, 1869770784, 2)]
    [Dictionary('CRE_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORLOTE: Double read FCRE_TOTALVALORLOTE write FCRE_TOTALVALORLOTE;
    const CRE_TOTALVALORLOTE_Name = 'CRE_TOTALVALORLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROSLOTE', ftBCD, 1699555104, 2)]
    [Dictionary('CRE_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROSLOTE: Double read FCRE_TOTALJUROSLOTE write FCRE_TOTALJUROSLOTE;
    const CRE_TOTALJUROSLOTE_Name = 'CRE_TOTALJUROSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTALOTE', ftBCD, 1380275039, 2)]
    [Dictionary('CRE_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTALOTE: Double read FCRE_TOTALMULTALOTE write FCRE_TOTALMULTALOTE;
    const CRE_TOTALMULTALOTE_Name = 'CRE_TOTALMULTALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTOLOTE', ftBCD, 6881394, 2)]
    [Dictionary('CRE_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTOLOTE: Double read FCRE_TOTALDESCTOLOTE write FCRE_TOTALDESCTOLOTE;
    const CRE_TOTALDESCTOLOTE_Name = 'CRE_TOTALDESCTOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIOLOTE', ftBCD, 656419879, 2)]
    [Dictionary('CRE_TOTALCARTORIOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIOLOTE: Double read FCRE_TOTALCARTORIOLOTE write FCRE_TOTALCARTORIOLOTE;
    const CRE_TOTALCARTORIOLOTE_Name = 'CRE_TOTALCARTORIOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESASLOTE', ftBCD, 1146045279, 2)]
    [Dictionary('CRE_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESASLOTE: Double read FCRE_TOTALOUTRASDESPESASLOTE write FCRE_TOTALOUTRASDESPESASLOTE;
    const CRE_TOTALOUTRASDESPESASLOTE_Name = 'CRE_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALORSUBSTITUIDO', ftBCD, 2097273, 2)]
    [Dictionary('SCR_TOTALVALORSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALORSUBSTITUIDO: Double read FSCR_TOTALVALORSUBSTITUIDO write FSCR_TOTALVALORSUBSTITUIDO;
    const SCR_TOTALVALORSUBSTITUIDO_Name = 'SCR_TOTALVALORSUBSTITUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALORSUBSTITUTO', ftBCD, 4456531, 2)]
    [Dictionary('SCR_TOTALVALORSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALORSUBSTITUTO: Double read FSCR_TOTALVALORSUBSTITUTO write FSCR_TOTALVALORSUBSTITUTO;
    const SCR_TOTALVALORSUBSTITUTO_Name = 'SCR_TOTALVALORSUBSTITUTO';

    [Restrictions([NoValidate])]
    [Column('SCR_TOTALCARTAOSUBSTITUTO', ftBCD, 1195983951, 2)]
    [Dictionary('SCR_TOTALCARTAOSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALCARTAOSUBSTITUTO: Double read FSCR_TOTALCARTAOSUBSTITUTO write FSCR_TOTALCARTAOSUBSTITUTO;
    const SCR_TOTALCARTAOSUBSTITUTO_Name = 'SCR_TOTALCARTAOSUBSTITUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALCHEQUESUBSTITUTO', ftBCD, 1397311055, 2)]
    [Dictionary('SCR_TOTALCHEQUESUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALCHEQUESUBSTITUTO: Double read FSCR_TOTALCHEQUESUBSTITUTO write FSCR_TOTALCHEQUESUBSTITUTO;
    const SCR_TOTALCHEQUESUBSTITUTO_Name = 'SCR_TOTALCHEQUESUBSTITUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PLANOCONTARATEIO', ftBCD, 218762555, 2)]
    [Dictionary('SCR_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PLANOCONTARATEIO: Double read FSCR_PLANOCONTARATEIO write FSCR_PLANOCONTARATEIO;
    const SCR_PLANOCONTARATEIO_Name = 'SCR_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('SCR_TOTALBASECOMISSAOLOTE', ftBCD, 1952672068, 2)]
    [Dictionary('SCR_TOTALBASECOMISSAOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALBASECOMISSAOLOTE: Double read FSCR_TOTALBASECOMISSAOLOTE write FSCR_TOTALBASECOMISSAOLOTE;
    const SCR_TOTALBASECOMISSAOLOTE_Name = 'SCR_TOTALBASECOMISSAOLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALCOMISSAOLOTE', ftBCD, 537529693, 2)]
    [Dictionary('CRE_TOTALCOMISSAOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCOMISSAOLOTE: Double read FCRE_TOTALCOMISSAOLOTE write FCRE_TOTALCOMISSAOLOTE;
    const CRE_TOTALCOMISSAOLOTE_Name = 'CRE_TOTALCOMISSAOLOTE';

    [Restrictions([NoValidate])]
    [Column('SCR_PERCENTUALCOMISSAO', ftBCD, 1162039111, 2)]
    [Dictionary('SCR_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_PERCENTUALCOMISSAO: Double read FSCR_PERCENTUALCOMISSAO write FSCR_PERCENTUALCOMISSAO;
    const SCR_PERCENTUALCOMISSAO_Name = 'SCR_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('SCR_HISTORICO', ftString, 300)]
    [Dictionary('SCR_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_HISTORICO: String read FSCR_HISTORICO write FSCR_HISTORICO;
    const SCR_HISTORICO_Name = 'SCR_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('SCR_OBSERVACAO', ftString, 300)]
    [Dictionary('SCR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_OBSERVACAO: String read FSCR_OBSERVACAO write FSCR_OBSERVACAO;
    const SCR_OBSERVACAO_Name = 'SCR_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PROCESSADO', ftString, 1)]
    [Dictionary('SCR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_PROCESSADO: String read FSCR_PROCESSADO write FSCR_PROCESSADO;
    const SCR_PROCESSADO_Name = 'SCR_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAALTERACAO: TDateTime read FSCR_DATAALTERACAO write FSCR_DATAALTERACAO;
    const SCR_DATAALTERACAO_Name = 'SCR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCR_PES_CODIGO', ftInteger)]
    [Dictionary('SCR_PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_PES_CODIGO: Integer read FSCR_PES_CODIGO write FSCR_PES_CODIGO;
    const SCR_PES_CODIGO_Name = 'SCR_PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SCR_ID_OLD', ftInteger)]
    [Dictionary('SCR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID_OLD: Integer read FSCR_ID_OLD write FSCR_ID_OLD;
    const SCR_ID_OLD_Name = 'SCR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCR_00)

end.
