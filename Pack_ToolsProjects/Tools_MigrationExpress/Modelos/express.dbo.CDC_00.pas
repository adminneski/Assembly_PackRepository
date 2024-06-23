unit express.dbo.CDC_00;

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
  [Table('CDC_00', '')]
  [PrimaryKey('CDC_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CDC_CODIGO')]
  TDtoCDC_00 = class
  private
    { Private declarations } 
    FCDC_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FCDC_DESCRICAO: String;
    FCDC_PERCENTUALFINANCEIRO: Double;
    FCDC_PERCENTUALDESCONTO: Double;
    FCDC_DESATIVADO: String;
    FCDC_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'CDC_00';
     const PrimaryKey = 'CDC_CODIGO';
     const Sequence   = 'SEQ_CDC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDC_CODIGO', ftInteger)]
    [Dictionary('CDC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDC_CODIGO: Integer read FCDC_CODIGO write FCDC_CODIGO;
    const CDC_CODIGO_Name = 'CDC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDC_DESCRICAO', ftString, 30)]
    [Dictionary('CDC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDC_DESCRICAO: String read FCDC_DESCRICAO write FCDC_DESCRICAO;
    const CDC_DESCRICAO_Name = 'CDC_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDC_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CDC_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDC_PERCENTUALFINANCEIRO: Double read FCDC_PERCENTUALFINANCEIRO write FCDC_PERCENTUALFINANCEIRO;
    const CDC_PERCENTUALFINANCEIRO_Name = 'CDC_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDC_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('CDC_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDC_PERCENTUALDESCONTO: Double read FCDC_PERCENTUALDESCONTO write FCDC_PERCENTUALDESCONTO;
    const CDC_PERCENTUALDESCONTO_Name = 'CDC_PERCENTUALDESCONTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDC_DESATIVADO', ftString, 1)]
    [Dictionary('CDC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDC_DESATIVADO: String read FCDC_DESATIVADO write FCDC_DESATIVADO;
    const CDC_DESATIVADO_Name = 'CDC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('CDC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CDC_DATAALTERACAO: TDateTime read FCDC_DATAALTERACAO write FCDC_DATAALTERACAO;
    const CDC_DATAALTERACAO_Name = 'CDC_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCDC_00)

end.
