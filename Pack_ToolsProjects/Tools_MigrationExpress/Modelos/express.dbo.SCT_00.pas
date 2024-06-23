unit express.dbo.SCT_00;

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
  [Table('SCT_00', '')]
  [PrimaryKey('SCT_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SCT_ID')]
  TDtoSCT_00 = class
  private
    { Private declarations } 
    FSCT_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCT_NUMERODOCTO: String;
    FSCT_DATALANCAMENTO: TDateTime;
    FCRE_TOTALICMSLOTE: Double;
    FCRE_TOTALJUROSLOTE: Double;
    FCRE_TOTALVALORLOTE: Double;
    FCRE_TOTALMULTALOTE: Double;
    FCRE_TOTALFRETELOTE: Double;
    FCRE_TOTALDESCTOLOTE: Double;
    FCRE_TOTALSEGUROLOTE: Double;
    FCRE_TOTALCARTORIOLOTE: Double;
    FCRE_TOTALOUTRASDESPESASLOTE: Double;
    FSCT_TOTALVALORSUBSTITUTO: Double;
    FSCT_TOTALVALORSUBSTITUIDO: Double;
    FSCT_CONDICAOESPECIAL: String;
    FSCT_OBSERVACAO: String;
    FSCT_PROCESSADO: String;
    FSCT_DATAALTERACAO: TDateTime;
    FSCT_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'SCT_00';
     const PrimaryKey = 'SCT_ID';
     const Sequence   = 'SEQ_SCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_ID', ftInteger)]
    [Dictionary('SCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID: Integer read FSCT_ID write FSCT_ID;
    const SCT_ID_Name = 'SCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NUMERODOCTO: String read FSCT_NUMERODOCTO write FSCT_NUMERODOCTO;
    const SCT_NUMERODOCTO_Name = 'SCT_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATALANCAMENTO: TDateTime read FSCT_DATALANCAMENTO write FSCT_DATALANCAMENTO;
    const SCT_DATALANCAMENTO_Name = 'SCT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALICMSLOTE', ftBCD, 1529377646, 2)]
    [Dictionary('CRE_TOTALICMSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALICMSLOTE: Double read FCRE_TOTALICMSLOTE write FCRE_TOTALICMSLOTE;
    const CRE_TOTALICMSLOTE_Name = 'CRE_TOTALICMSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROSLOTE', ftBCD, 4522064, 2)]
    [Dictionary('CRE_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROSLOTE: Double read FCRE_TOTALJUROSLOTE write FCRE_TOTALJUROSLOTE;
    const CRE_TOTALJUROSLOTE_Name = 'CRE_TOTALJUROSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORLOTE', ftBCD, 1952867660, 2)]
    [Dictionary('CRE_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORLOTE: Double read FCRE_TOTALVALORLOTE write FCRE_TOTALVALORLOTE;
    const CRE_TOTALVALORLOTE_Name = 'CRE_TOTALVALORLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTALOTE', ftBCD, 2097273, 2)]
    [Dictionary('CRE_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTALOTE: Double read FCRE_TOTALMULTALOTE write FCRE_TOTALMULTALOTE;
    const CRE_TOTALMULTALOTE_Name = 'CRE_TOTALMULTALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFRETELOTE', ftBCD, 4456531, 2)]
    [Dictionary('CRE_TOTALFRETELOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFRETELOTE: Double read FCRE_TOTALFRETELOTE write FCRE_TOTALFRETELOTE;
    const CRE_TOTALFRETELOTE_Name = 'CRE_TOTALFRETELOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTOLOTE', ftBCD, 1195983951, 2)]
    [Dictionary('CRE_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTOLOTE: Double read FCRE_TOTALDESCTOLOTE write FCRE_TOTALDESCTOLOTE;
    const CRE_TOTALDESCTOLOTE_Name = 'CRE_TOTALDESCTOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALSEGUROLOTE', ftBCD, 1397311055, 2)]
    [Dictionary('CRE_TOTALSEGUROLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALSEGUROLOTE: Double read FCRE_TOTALSEGUROLOTE write FCRE_TOTALSEGUROLOTE;
    const CRE_TOTALSEGUROLOTE_Name = 'CRE_TOTALSEGUROLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIOLOTE', ftBCD, 218762555, 2)]
    [Dictionary('CRE_TOTALCARTORIOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIOLOTE: Double read FCRE_TOTALCARTORIOLOTE write FCRE_TOTALCARTORIOLOTE;
    const CRE_TOTALCARTORIOLOTE_Name = 'CRE_TOTALCARTORIOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESASLOTE', ftBCD, 1952672068, 2)]
    [Dictionary('CRE_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESASLOTE: Double read FCRE_TOTALOUTRASDESPESASLOTE write FCRE_TOTALOUTRASDESPESASLOTE;
    const CRE_TOTALOUTRASDESPESASLOTE_Name = 'CRE_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_TOTALVALORSUBSTITUTO', ftBCD, 537529693, 2)]
    [Dictionary('SCT_TOTALVALORSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALORSUBSTITUTO: Double read FSCT_TOTALVALORSUBSTITUTO write FSCT_TOTALVALORSUBSTITUTO;
    const SCT_TOTALVALORSUBSTITUTO_Name = 'SCT_TOTALVALORSUBSTITUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_TOTALVALORSUBSTITUIDO', ftBCD, 1162039111, 2)]
    [Dictionary('SCT_TOTALVALORSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALORSUBSTITUIDO: Double read FSCT_TOTALVALORSUBSTITUIDO write FSCT_TOTALVALORSUBSTITUIDO;
    const SCT_TOTALVALORSUBSTITUIDO_Name = 'SCT_TOTALVALORSUBSTITUIDO';

    [Restrictions([NoValidate])]
    [Column('SCT_CONDICAOESPECIAL', ftString, 5000)]
    [Dictionary('SCT_CONDICAOESPECIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_CONDICAOESPECIAL: String read FSCT_CONDICAOESPECIAL write FSCT_CONDICAOESPECIAL;
    const SCT_CONDICAOESPECIAL_Name = 'SCT_CONDICAOESPECIAL';

    [Restrictions([NoValidate])]
    [Column('SCT_OBSERVACAO', ftString, 300)]
    [Dictionary('SCT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_OBSERVACAO: String read FSCT_OBSERVACAO write FSCT_OBSERVACAO;
    const SCT_OBSERVACAO_Name = 'SCT_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_PROCESSADO', ftString, 1)]
    [Dictionary('SCT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_PROCESSADO: String read FSCT_PROCESSADO write FSCT_PROCESSADO;
    const SCT_PROCESSADO_Name = 'SCT_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAALTERACAO', ftDateTime)]
    [Dictionary('SCT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAALTERACAO: TDateTime read FSCT_DATAALTERACAO write FSCT_DATAALTERACAO;
    const SCT_DATAALTERACAO_Name = 'SCT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('SCT_ID_OLD', ftInteger)]
    [Dictionary('SCT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID_OLD: Integer read FSCT_ID_OLD write FSCT_ID_OLD;
    const SCT_ID_OLD_Name = 'SCT_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSCT_00)

end.
