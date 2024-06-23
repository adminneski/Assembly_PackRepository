unit express.dbo.VW_PSQ_BCC;

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
  [Table('VW_PSQ_BCC', '')]
  TDtoVW_PSQ_BCC = class
  private
    { Private declarations } 
    FBCR_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCR_DATALANCAMENTO: TDateTime;
    FBCR_TIPODOCUMENTO: String;
    FBCR_PROCESSADO: String;
    FCTA_CODIGO: Integer;
    FCTA_EMITENTE: String;
    FBCR_HISTORICO: String;
    FCRE_TOTALVALORBAIXALOTE: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_BCC';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCR_DATALANCAMENTO: TDateTime read FBCR_DATALANCAMENTO write FBCR_DATALANCAMENTO;
    const BCR_DATALANCAMENTO_Name = 'BCR_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('BCR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_TIPODOCUMENTO: String read FBCR_TIPODOCUMENTO write FBCR_TIPODOCUMENTO;
    const BCR_TIPODOCUMENTO_Name = 'BCR_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCR_PROCESSADO', ftString, 1)]
    [Dictionary('BCR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_PROCESSADO: String read FBCR_PROCESSADO write FBCR_PROCESSADO;
    const BCR_PROCESSADO_Name = 'BCR_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('BCR_HISTORICO', ftString, 5000)]
    [Dictionary('BCR_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCR_HISTORICO: String read FBCR_HISTORICO write FBCR_HISTORICO;
    const BCR_HISTORICO_Name = 'BCR_HISTORICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXALOTE', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXALOTE: Double read FCRE_TOTALVALORBAIXALOTE write FCRE_TOTALVALORBAIXALOTE;
    const CRE_TOTALVALORBAIXALOTE_Name = 'CRE_TOTALVALORBAIXALOTE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_BCC)

end.
