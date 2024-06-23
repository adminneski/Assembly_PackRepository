unit express.dbo.RFC_00;

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
  [Table('RFC_00', '')]
  [PrimaryKey('RFC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RFC_ID')]
  TDtoRFC_00 = class
  private
    { Private declarations } 
    FRFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FCGA_ID: Integer;
    FRFC_DATALANCAMENTO: TDateTime;
    FRFC_TOTALPESO: Double;
    FRFC_TOTALFALTA: Double;
    FRFC_TOTALAVARIA: Double;
    FRFC_TOTALQUEBRA: Double;
    FRFC_TOTALVALETRP: Double;
    FRFC_TOTALDESPESAS: Double;
    FRFC_TOTALFATURADO: Double;
    FRFC_TOTALFINANCEIRO: Double;
    FRFC_TOTALDEVOLUCAO: Double;
    FRFC_TOTALCANCELADO: Double;
    FRFC_TOTALADIANTAMENTOTRP: Double;
    FRFC_OBSERVACAO: String;
    FRFC_PROCESSADO: String;
    FRFC_DATAALTERACAO: TDateTime;
    FRFC_ID_OLD: Integer;
    FCGA_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'RFC_00';
     const PrimaryKey = 'RFC_ID';
     const Sequence   = 'SEQ_RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_ID', ftInteger)]
    [Dictionary('RFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID: Integer read FRFC_ID write FRFC_ID;
    const RFC_ID_Name = 'RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RFC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RFC_DATALANCAMENTO: TDateTime read FRFC_DATALANCAMENTO write FRFC_DATALANCAMENTO;
    const RFC_DATALANCAMENTO_Name = 'RFC_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALPESO', ftBCD, 1835362145, 2)]
    [Dictionary('RFC_TOTALPESO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALPESO: Double read FRFC_TOTALPESO write FRFC_TOTALPESO;
    const RFC_TOTALPESO_Name = 'RFC_TOTALPESO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALFALTA', ftBCD, 1145132617, 2)]
    [Dictionary('RFC_TOTALFALTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALFALTA: Double read FRFC_TOTALFALTA write FRFC_TOTALFALTA;
    const RFC_TOTALFALTA_Name = 'RFC_TOTALFALTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALAVARIA', ftBCD, 1952531540, 2)]
    [Dictionary('RFC_TOTALAVARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALAVARIA: Double read FRFC_TOTALAVARIA write FRFC_TOTALAVARIA;
    const RFC_TOTALAVARIA_Name = 'RFC_TOTALAVARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALQUEBRA', ftBCD, 1769238085, 2)]
    [Dictionary('RFC_TOTALQUEBRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALQUEBRA: Double read FRFC_TOTALQUEBRA write FRFC_TOTALQUEBRA;
    const RFC_TOTALQUEBRA_Name = 'RFC_TOTALQUEBRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALVALETRP', ftBCD, 1415532614, 2)]
    [Dictionary('RFC_TOTALVALETRP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALVALETRP: Double read FRFC_TOTALVALETRP write FRFC_TOTALVALETRP;
    const RFC_TOTALVALETRP_Name = 'RFC_TOTALVALETRP';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALDESPESAS', ftBCD, 1380275039, 2)]
    [Dictionary('RFC_TOTALDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALDESPESAS: Double read FRFC_TOTALDESPESAS write FRFC_TOTALDESPESAS;
    const RFC_TOTALDESPESAS_Name = 'RFC_TOTALDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALFATURADO', ftBCD, 1702129225, 2)]
    [Dictionary('RFC_TOTALFATURADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALFATURADO: Double read FRFC_TOTALFATURADO write FRFC_TOTALFATURADO;
    const RFC_TOTALFATURADO_Name = 'RFC_TOTALFATURADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALFINANCEIRO', ftBCD, 659507017, 2)]
    [Dictionary('RFC_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALFINANCEIRO: Double read FRFC_TOTALFINANCEIRO write FRFC_TOTALFINANCEIRO;
    const RFC_TOTALFINANCEIRO_Name = 'RFC_TOTALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALDEVOLUCAO', ftBCD, 1869770784, 2)]
    [Dictionary('RFC_TOTALDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALDEVOLUCAO: Double read FRFC_TOTALDEVOLUCAO write FRFC_TOTALDEVOLUCAO;
    const RFC_TOTALDEVOLUCAO_Name = 'RFC_TOTALDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('RFC_TOTALCANCELADO', ftBCD, 1529377646, 2)]
    [Dictionary('RFC_TOTALCANCELADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALCANCELADO: Double read FRFC_TOTALCANCELADO write FRFC_TOTALCANCELADO;
    const RFC_TOTALCANCELADO_Name = 'RFC_TOTALCANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALADIANTAMENTOTRP', ftBCD, 4522064, 2)]
    [Dictionary('RFC_TOTALADIANTAMENTOTRP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALADIANTAMENTOTRP: Double read FRFC_TOTALADIANTAMENTOTRP write FRFC_TOTALADIANTAMENTOTRP;
    const RFC_TOTALADIANTAMENTOTRP_Name = 'RFC_TOTALADIANTAMENTOTRP';

    [Restrictions([NoValidate])]
    [Column('RFC_OBSERVACAO', ftString, 1000)]
    [Dictionary('RFC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_OBSERVACAO: String read FRFC_OBSERVACAO write FRFC_OBSERVACAO;
    const RFC_OBSERVACAO_Name = 'RFC_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_PROCESSADO', ftString, 1)]
    [Dictionary('RFC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_PROCESSADO: String read FRFC_PROCESSADO write FRFC_PROCESSADO;
    const RFC_PROCESSADO_Name = 'RFC_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RFC_DATAALTERACAO: TDateTime read FRFC_DATAALTERACAO write FRFC_DATAALTERACAO;
    const RFC_DATAALTERACAO_Name = 'RFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('RFC_ID_OLD', ftInteger)]
    [Dictionary('RFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID_OLD: Integer read FRFC_ID_OLD write FRFC_ID_OLD;
    const RFC_ID_OLD_Name = 'RFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID_OLD: Integer read FCGA_ID_OLD write FCGA_ID_OLD;
    const CGA_ID_OLD_Name = 'CGA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRFC_00)

end.
