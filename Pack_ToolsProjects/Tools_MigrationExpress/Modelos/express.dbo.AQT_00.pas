unit express.dbo.AQT_00;

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
  [Table('AQT_00', '')]
  [PrimaryKey('AQT_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AQT_CODIGO')]
  TDtoAQT_00 = class
  private
    { Private declarations } 
    FAQT_CODIGO: Integer;
    FAQT_DESCRICAO: String;
    FAQT_ALIQUOTA: Double;
    FAQT_ALIQUOTAECF: String;
    FAQT_DESATIVADO: String;
    FAQT_DATAALTERACAO: TDateTime;
    FAQT_TIPOALIQUOTA: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'AQT_00';
     const PrimaryKey = 'AQT_CODIGO';
     const Sequence   = 'SEQ_AQT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AQT_CODIGO', ftInteger)]
    [Dictionary('AQT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO: Integer read FAQT_CODIGO write FAQT_CODIGO;
    const AQT_CODIGO_Name = 'AQT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AQT_DESCRICAO', ftString, 30)]
    [Dictionary('AQT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESCRICAO: String read FAQT_DESCRICAO write FAQT_DESCRICAO;
    const AQT_DESCRICAO_Name = 'AQT_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AQT_ALIQUOTA', ftBCD)]
    [Dictionary('AQT_ALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AQT_ALIQUOTA: Double read FAQT_ALIQUOTA write FAQT_ALIQUOTA;
    const AQT_ALIQUOTA_Name = 'AQT_ALIQUOTA';

    [Restrictions([NoValidate])]
    [Column('AQT_ALIQUOTAECF', ftString, 5)]
    [Dictionary('AQT_ALIQUOTAECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_ALIQUOTAECF: String read FAQT_ALIQUOTAECF write FAQT_ALIQUOTAECF;
    const AQT_ALIQUOTAECF_Name = 'AQT_ALIQUOTAECF';

    [Restrictions([NoValidate, NotNull])]
    [Column('AQT_DESATIVADO', ftString, 1)]
    [Dictionary('AQT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_DESATIVADO: String read FAQT_DESATIVADO write FAQT_DESATIVADO;
    const AQT_DESATIVADO_Name = 'AQT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AQT_DATAALTERACAO', ftDateTime)]
    [Dictionary('AQT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property AQT_DATAALTERACAO: TDateTime read FAQT_DATAALTERACAO write FAQT_DATAALTERACAO;
    const AQT_DATAALTERACAO_Name = 'AQT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('AQT_TIPOALIQUOTA', ftString, 2)]
    [Dictionary('AQT_TIPOALIQUOTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AQT_TIPOALIQUOTA: String read FAQT_TIPOALIQUOTA write FAQT_TIPOALIQUOTA;
    const AQT_TIPOALIQUOTA_Name = 'AQT_TIPOALIQUOTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAQT_00)

end.
