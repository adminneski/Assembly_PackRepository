unit express.dbo.VW_PSQ_PDC;

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
  [Table('VW_PSQ_PDC', '')]
  TDtoVW_PSQ_PDC = class
  private
    { Private declarations } 
    FPDC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDC_NUMERODOCTO: String;
    FPDC_DATALANCAMENTO: TDateTime;
    FPDC_OBSERVACAO: String;
    FPDC_PROCESSADO: String;
    FFSP_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FNLP_NUMEROLOTE: String;
    FPDC_TOTALQTDPRODUCAO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PDC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_ID', ftInteger)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PDC_NUMERODOCTO', ftString, 15)]
    [Dictionary('PDC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_NUMERODOCTO: String read FPDC_NUMERODOCTO write FPDC_NUMERODOCTO;
    const PDC_NUMERODOCTO_Name = 'PDC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PDC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDC_DATALANCAMENTO: TDateTime read FPDC_DATALANCAMENTO write FPDC_DATALANCAMENTO;
    const PDC_DATALANCAMENTO_Name = 'PDC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PDC_OBSERVACAO', ftString, 300)]
    [Dictionary('PDC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_OBSERVACAO: String read FPDC_OBSERVACAO write FPDC_OBSERVACAO;
    const PDC_OBSERVACAO_Name = 'PDC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_PROCESSADO', ftString, 1)]
    [Dictionary('PDC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_PROCESSADO: String read FPDC_PROCESSADO write FPDC_PROCESSADO;
    const PDC_PROCESSADO_Name = 'PDC_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('FSP_CODIGO', ftInteger)]
    [Dictionary('FSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FSP_CODIGO: Integer read FFSP_CODIGO write FFSP_CODIGO;
    const FSP_CODIGO_Name = 'FSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_CODIGO', ftInteger)]
    [Dictionary('NLP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NLP_CODIGO: Integer read FNLP_CODIGO write FNLP_CODIGO;
    const NLP_CODIGO_Name = 'NLP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_NUMEROLOTE', ftString, 15)]
    [Dictionary('NLP_NUMEROLOTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NLP_NUMEROLOTE: String read FNLP_NUMEROLOTE write FNLP_NUMEROLOTE;
    const NLP_NUMEROLOTE_Name = 'NLP_NUMEROLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALQTDPRODUCAO', ftBCD, 48, 3)]
    [Dictionary('PDC_TOTALQTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALQTDPRODUCAO: Double read FPDC_TOTALQTDPRODUCAO write FPDC_TOTALQTDPRODUCAO;
    const PDC_TOTALQTDPRODUCAO_Name = 'PDC_TOTALQTDPRODUCAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PDC)

end.
