unit express.dbo.VW_PSQ_PPD;

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
  [Table('VW_PSQ_PPD', '')]
  TDtoVW_PSQ_PPD = class
  private
    { Private declarations } 
    FPPD_ID: Integer;
    FCOM_CODIGO: Integer;
    FPPD_NUMERODOCTO: String;
    FPPD_DATALANCAMENTO: TDateTime;
    FPPD_OBSERVACAO: String;
    FPPD_PROCESSADO: String;
    FFSP_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FNLP_NUMEROLOTE: String;
    FPPD_TOTALQTDPRODUCAO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PPD';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_ID', ftInteger)]
    [Dictionary('PPD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID: Integer read FPPD_ID write FPPD_ID;
    const PPD_ID_Name = 'PPD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PPD_NUMERODOCTO', ftString, 15)]
    [Dictionary('PPD_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_NUMERODOCTO: String read FPPD_NUMERODOCTO write FPPD_NUMERODOCTO;
    const PPD_NUMERODOCTO_Name = 'PPD_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PPD_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PPD_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PPD_DATALANCAMENTO: TDateTime read FPPD_DATALANCAMENTO write FPPD_DATALANCAMENTO;
    const PPD_DATALANCAMENTO_Name = 'PPD_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PPD_OBSERVACAO', ftString, 300)]
    [Dictionary('PPD_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_OBSERVACAO: String read FPPD_OBSERVACAO write FPPD_OBSERVACAO;
    const PPD_OBSERVACAO_Name = 'PPD_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PPD_PROCESSADO', ftString, 1)]
    [Dictionary('PPD_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_PROCESSADO: String read FPPD_PROCESSADO write FPPD_PROCESSADO;
    const PPD_PROCESSADO_Name = 'PPD_PROCESSADO';

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
    [Column('PPD_TOTALQTDPRODUCAO', ftBCD)]
    [Dictionary('PPD_TOTALQTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALQTDPRODUCAO: Double read FPPD_TOTALQTDPRODUCAO write FPPD_TOTALQTDPRODUCAO;
    const PPD_TOTALQTDPRODUCAO_Name = 'PPD_TOTALQTDPRODUCAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PPD)

end.
