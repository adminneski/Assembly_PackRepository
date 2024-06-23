unit express.dbo.SCP_00;

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
  [Table('SCP_00', '')]
  [PrimaryKey('SCP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCP_ID')]
  TDtoSCP_00 = class
  private
    { Private declarations } 
    FSCP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FSCP_DATALANCAMENTO: TDateTime;
    FCPA_TOTALVALORLOTE: Double;
    FCPA_TOTALJUROSLOTE: Double;
    FCPA_TOTALMULTALOTE: Double;
    FCPA_TOTALDESCTOLOTE: Double;
    FCPA_TOTALOUTRASDESPESASLOTE: Double;
    FSCP_TOTALVALORSUBSTITUIDO: Double;
    FSCP_TOTALVALORSUBSTITUTO: Double;
    FSCP_PLANOCONTARATEIO: Double;
    FSCP_HISTORICO: String;
    FSCP_OBSERVACAO: String;
    FSCP_PROCESSADO: String;
    FSCP_DATAALTERACAO: TDateTime;
    FSCP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'SCP_00';
     const PrimaryKey = 'SCP_ID';
     const Sequence   = 'SEQ_SCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_ID', ftInteger)]
    [Dictionary('SCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID: Integer read FSCP_ID write FSCP_ID;
    const SCP_ID_Name = 'SCP_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATALANCAMENTO: TDateTime read FSCP_DATALANCAMENTO write FSCP_DATALANCAMENTO;
    const SCP_DATALANCAMENTO_Name = 'SCP_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALVALORLOTE', ftBCD, 1769238085, 2)]
    [Dictionary('CPA_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORLOTE: Double read FCPA_TOTALVALORLOTE write FCPA_TOTALVALORLOTE;
    const CPA_TOTALVALORLOTE_Name = 'CPA_TOTALVALORLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALJUROSLOTE', ftBCD, 5177428, 2)]
    [Dictionary('CPA_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROSLOTE: Double read FCPA_TOTALJUROSLOTE write FCPA_TOTALJUROSLOTE;
    const CPA_TOTALJUROSLOTE_Name = 'CPA_TOTALJUROSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALMULTALOTE', ftBCD, 1835362145, 2)]
    [Dictionary('CPA_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTALOTE: Double read FCPA_TOTALMULTALOTE write FCPA_TOTALMULTALOTE;
    const CPA_TOTALMULTALOTE_Name = 'CPA_TOTALMULTALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALDESCTOLOTE', ftBCD, 1145132617, 2)]
    [Dictionary('CPA_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTOLOTE: Double read FCPA_TOTALDESCTOLOTE write FCPA_TOTALDESCTOLOTE;
    const CPA_TOTALDESCTOLOTE_Name = 'CPA_TOTALDESCTOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_TOTALOUTRASDESPESASLOTE', ftBCD, 1411398223, 2)]
    [Dictionary('CPA_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESASLOTE: Double read FCPA_TOTALOUTRASDESPESASLOTE write FCPA_TOTALOUTRASDESPESASLOTE;
    const CPA_TOTALOUTRASDESPESASLOTE_Name = 'CPA_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_TOTALVALORSUBSTITUIDO', ftBCD, 539780974, 2)]
    [Dictionary('SCP_TOTALVALORSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_TOTALVALORSUBSTITUIDO: Double read FSCP_TOTALVALORSUBSTITUIDO write FSCP_TOTALVALORSUBSTITUIDO;
    const SCP_TOTALVALORSUBSTITUIDO_Name = 'SCP_TOTALVALORSUBSTITUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_TOTALVALORSUBSTITUTO', ftBCD, 1415532614, 2)]
    [Dictionary('SCP_TOTALVALORSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_TOTALVALORSUBSTITUTO: Double read FSCP_TOTALVALORSUBSTITUTO write FSCP_TOTALVALORSUBSTITUTO;
    const SCP_TOTALVALORSUBSTITUTO_Name = 'SCP_TOTALVALORSUBSTITUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PLANOCONTARATEIO', ftBCD, 1952867660, 2)]
    [Dictionary('SCP_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCP_PLANOCONTARATEIO: Double read FSCP_PLANOCONTARATEIO write FSCP_PLANOCONTARATEIO;
    const SCP_PLANOCONTARATEIO_Name = 'SCP_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('SCP_HISTORICO', ftString, 300)]
    [Dictionary('SCP_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_HISTORICO: String read FSCP_HISTORICO write FSCP_HISTORICO;
    const SCP_HISTORICO_Name = 'SCP_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('SCP_OBSERVACAO', ftString, 300)]
    [Dictionary('SCP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_OBSERVACAO: String read FSCP_OBSERVACAO write FSCP_OBSERVACAO;
    const SCP_OBSERVACAO_Name = 'SCP_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_PROCESSADO', ftString, 1)]
    [Dictionary('SCP_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCP_PROCESSADO: String read FSCP_PROCESSADO write FSCP_PROCESSADO;
    const SCP_PROCESSADO_Name = 'SCP_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCP_DATAALTERACAO: TDateTime read FSCP_DATAALTERACAO write FSCP_DATAALTERACAO;
    const SCP_DATAALTERACAO_Name = 'SCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCP_ID_OLD', ftInteger)]
    [Dictionary('SCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCP_ID_OLD: Integer read FSCP_ID_OLD write FSCP_ID_OLD;
    const SCP_ID_OLD_Name = 'SCP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCP_00)

end.
